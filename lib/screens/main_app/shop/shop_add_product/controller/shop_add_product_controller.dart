import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/models/product_model.dart';
import 'package:tradeupapp/widgets/general/general_snackbar_helper.dart';

class AddProductController extends GetxController {
  //Có thể gọi ra controller ở bất kỳ đâu mà ko cần gọi lại
  static AddProductController get instance => Get.find();

  final pageController = PageController();

  //Chỉ số step hiện tại
  Rx<int> currentStepIndex = 0.obs;

  //Tiến độ hiện tại và cũ (dùng cho Progress Bar animation)
  RxDouble currentProgress = 0.0.obs;
  RxInt currentStep = 0.obs;
  RxDouble oldProgress = 0.0.obs;
  RxInt oldStep = 0.obs;

  //Trạng thái hiển thị (dùng cho Box Helper)
  final showHelpDialog = true.obs; //Ban đầu hiện

  //Step 1: Basic Product Info
  final productNameController = TextEditingController();
  final productPriceController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final selectedCondition = RxnString(); // nullable String

  //Step 2: Images and Categories
  RxList<String> categories = <String>[].obs;

  //Danh sách hình ảnh (dùng cho Image Picker, chứa ảnh local để hiển thị)
  RxList<File> imageList = <File>[].obs;

  //Step 3: Post and Feeds
  final productStoryController = TextEditingController();

  //Loading cho submit
  var isSubmitting = false.obs;

  /// ---------------------
  /// Navigation Functions
  /// ---------------------

  //Cập nhật index khi chuyển trang
  void updateStepIndicator(index) => currentStepIndex.value = index;

  //Chuyển sang step tiếp theo
  void nextStep() {
    //Ẩn bàn phím trước khi chuyển trang
    FocusManager.instance.primaryFocus?.unfocus();

    //Thực hiện validate step trước khi next
    //Bỏ qua validate nếu skipValidation = true
    if (!_validateCurrentStep()) return;

    int totalSteps = 3; // 0-2 là form, 3 là finish

    //Nếu đang ở bước cuối cùng của quy trình thực sự là bước 3 Creating New Feeds
    if (currentStepIndex.value == totalSteps - 1) {
      //Cập nhật 100% progress
      updateProgress(1.0, totalSteps);

      //Chuyển sang trang Finish
      pageController.animateToPage(
        currentStepIndex.value + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      currentStepIndex.value++;
      return;
    }

    //Các bước từ 0 tới 2 thì thực hiện bình thương
    if (currentStepIndex.value < totalSteps - 1) {
      int page = currentStepIndex.value + 1;
      pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

      //Cập nhật progress (chia cho tổng bước thực tế)
      updateProgress((page + 1) / totalSteps, page + 1);
      currentStepIndex.value = page;
    }
  }

  //Quay lại step trước
  void previousStep() {
    if (currentStepIndex.value > 0) {
      int page = currentStepIndex.value - 1;
      pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

      // Cập nhật progress
      updateProgress((page + 1) / 3, page + 1);
      currentStepIndex.value = page;
    }
  }

  /// ---------------------------
  /// Validation And Submit Logic
  /// ---------------------------

  bool _validateCurrentStep() {
    //Step 1: Validate thông tin cơ bản
    if (currentStepIndex.value == 0) {
      if (productNameController.text.trim().isEmpty) {
        SnackbarHelperGeneral.showCustomSnackBar(
          'Please enter your product name before move to next stage.',
        );
        return false;
      }
      if (productPriceController.text.trim().isEmpty) {
        SnackbarHelperGeneral.showCustomSnackBar(
          "Please enter price before move to next stage.",
        );
        return false;
      }
      if (selectedCondition.value == null) {
        SnackbarHelperGeneral.showCustomSnackBar(
          "Please choose condition before move to next stage.",
        );
        return false;
      }
    }

    //Step 2: Validate ảnh và danh mục
    if (currentStepIndex.value == 1) {
      if (imageList.isEmpty) {
        SnackbarHelperGeneral.showCustomSnackBar(
          "Please choose at least one image before move to next stage.",
        );
        return false;
      }
      if (categories.isEmpty) {
        SnackbarHelperGeneral.showCustomSnackBar(
          "Please choose at least one tag before move to next stage.",
        );
        return false;
      }
    }

    //Step 3: Validate feeds
    if (currentStepIndex.value == 2) {
      if (productStoryController.text.trim().isEmpty) {
        SnackbarHelperGeneral.showCustomSnackBar(
          "Please enter your product story before finishing.",
        );
        return false;
      }
    }

    return true;
  }

  //Hàm upload ảnh lên Cloudinary và lấy URL
  Future<String?> uploadToCloudinary(File imageFile) async {
    const cloudName = 'dhmzkwjlf';
    const uploadPreset = 'flutter_upload';

    final url = Uri.parse(
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
    );

    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final resStr = await response.stream.bytesToString();
      final resData = json.decode(resStr);
      return resData['secure_url']; // link ảnh
    } else {
      SnackbarHelperGeneral.showCustomSnackBar(
        // ignore: use_build_context_synchronously
        'Upload failed: ${response.statusCode}',
        backgroundColor: Colors.red,
      );
      return null;
    }
  }

  //Submit product lên Firestore
  Future<void> submitProduct() async {
    FocusManager.instance.primaryFocus?.unfocus();

    try {
      isSubmitting.value = true;
      //Lấy userId từ FirebaseAuth
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        Get.snackbar("Error", "You must be logged in to post a product");
        return;
      }

      //Gọi hàm upload ảnh lên cloudinary
      List<String> urlImageList = [];
      if (imageList.isNotEmpty) {
        for (var imageFile in imageList) {
          String? url;
          url = await uploadToCloudinary(imageFile);
          if (url == null) {
            SnackbarHelperGeneral.showCustomSnackBar(
              'Failed to upload image. Please try again.',
              backgroundColor: Colors.red,
            );
            return;
          } else {
            urlImageList.add(url);
          }
        }
      }

      //Tạo ProductModel từ dữ liệu nhập
      final product = ProductModel(
        productId: null, //Firestore sẽ tự sinh ID
        userId: currentUser.uid,
        productName: productNameController.text.trim(),
        productPrice:
            double.tryParse(productPriceController.text.trim()) ?? 0.0,
        productDescription: productDescriptionController.text.trim(),
        selectedCondition: selectedCondition.value,
        categoryList: categories.toList(),
        imageList: urlImageList,
        productStory: productStoryController.text.trim(),
        status: 0,
        createdAt: Timestamp.now(),
        likedBy: [],
      );

      //Gọi DatabaseService để lưu lên Firestore
      await DatabaseService().addProduct(product);

      SnackbarHelperGeneral.showCustomSnackBar(
        'Successfully adding product',
        backgroundColor: Colors.green,
      );
      resetForm();
    } catch (e) {
      SnackbarHelperGeneral.showCustomSnackBar(
        'Failed to add product due to: $e',
        backgroundColor: Colors.red,
      );
    } finally {
      isSubmitting.value = false;

      //Đi thẳng sang Finish page mà không validate lại
      WidgetsBinding.instance.addPostFrameCallback((_) {
        int totalSteps = 3;

        //cập nhật progress = 100%
        updateProgress(1.0, totalSteps);

        pageController.animateToPage(
          totalSteps, // Finish page index (3)
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );

        currentStepIndex.value = totalSteps;
      });
    }
  }

  //Hàm reset lại form sau khi submit thành công
  void resetForm() {
    productNameController.clear();
    productPriceController.clear();
    productDescriptionController.clear();
    selectedCondition.value = null;
    categories.clear();
    imageList.clear();
    productStoryController.clear();
    currentStepIndex.value = 0;
    currentProgress.value = 0.0;
  }

  /// -----------------
  /// Help Box Function
  /// -----------------

  //Ẩn hộp trợ giúp
  void hideHelpDialog() => showHelpDialog.value = false;

  //Hiện hộp trợ giúp lại
  void showHelpDialogAgain() => showHelpDialog.value = true;

  /// ---------------------
  /// Progress Bar Function
  /// ---------------------

  //Cập nhật progress (gọi khi chuyển bước)
  void updateProgress(double newProgress, int step) {
    //Lưu lại giá trị cũ
    oldProgress.value = currentProgress.value;
    oldStep.value = currentStep.value;

    //Cập nhật giá trị mới
    currentProgress.value = newProgress;
    currentStep.value = step;
  }

  /// ------------------------------
  /// Image Picker Function (Step 2)
  /// ------------------------------

  //Hàm hiển thị Bottome sheet: Chụp ảnh hoặc Upload ảnh từ thiết bị
  void showImagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //Thanh kéo trên cùng
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                //Chụp ảnh bằng camera
                ListTile(
                  leading: const Icon(Iconsax.camera, color: AppColors.header),
                  title: const Text(
                    'Take a photo with Camera',
                    style: TextStyle(
                      fontFamily: 'Roboto-Medium',
                      fontSize: 15,
                      color: AppColors.header,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImageFromCamera();
                  },
                ),

                //Chọn ảnh từ thư viện
                ListTile(
                  leading: const Icon(Iconsax.image, color: AppColors.header),
                  title: const Text(
                    'Choose Photo from Gallery',
                    style: TextStyle(
                      fontFamily: 'Roboto-Medium',
                      fontSize: 15,
                      color: AppColors.header,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImageFromGallery();
                  },
                ),

                const Divider(height: 1),

                //Nút hủy
                ListTile(
                  leading: const Icon(
                    Iconsax.close_circle,
                    color: Colors.redAccent,
                  ),
                  title: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontFamily: 'Roboto-Medium',
                      fontSize: 15,
                      color: Colors.redAccent,
                    ),
                  ),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //Hàm chọn ảnh từ gallery
  Future<void> _pickImageFromGallery({int? replaceIndex}) async {
    if (replaceIndex == null && imageList.length >= 5) {
      SnackbarHelperGeneral.showCustomSnackBar(
        'Only 5 images are allowed for upload!',
        backgroundColor: Colors.orange,
      );
      return;
    }
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      final file = File(pickedImage.path);
      if (replaceIndex != null) {
        imageList[replaceIndex] = file;
      } else {
        imageList.add(file);
      }
    }
  }

  //Chụp ảnh từ camera
  Future<void> _pickImageFromCamera({int? replaceIndex}) async {
    if (replaceIndex == null && imageList.length >= 5) {
      SnackbarHelperGeneral.showCustomSnackBar(
        'Only 5 images are allowed for upload!',
        backgroundColor: Colors.orange,
      );
      return;
    }
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedImage != null) {
      final file = File(pickedImage.path);
      if (replaceIndex != null) {
        imageList[replaceIndex] = file;
      } else {
        imageList.add(file);
      }
    }
  }

  //Thêm hình ảnh vào image list và theo dõi số image đã upload
  void addNewImageToImageList(File image) {
    if (!imageList.any((file) => file.path == image.path)) {
      imageList.add(image);
    }
  }

  // Xóa ảnh tại vị trí thứ i
  void removeImageAt(int index) {
    imageList.removeAt(index);
  }
}
