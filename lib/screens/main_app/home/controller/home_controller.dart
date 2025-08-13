import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/models/category_model.dart';
import 'package:tradeupapp/models/product_model.dart';
import 'package:tradeupapp/models/search_history_model.dart';
import 'package:tradeupapp/models/user_model.dart';

class HomeController extends GetxController {
  ///-----------
  /// Variables (Danh sách các biến khai báo trong Controller)
  ///-----------

  //User data của người dùng
  var user = Rxn<UserModal>();

  //Danh sách User lấy từ Firebase
  var userList = <UserModal>[].obs;

  //Map cho User Id va User Name
  var userIdToUserName = <String, String>{}.obs;

  //Danh sách sản phẩm đã lọc theo gợi ý, tối đa 10 sản phẩm (dùng cho Sort Option Group)
  var productList = <ProductModel>[].obs;
  var selectedSortOption = 'Newest'.obs;

  //Danh sách Category lấy từ Firebase
  var categoryList = <CategoryModel>[].obs;

  //Danh sách Search History của User
  var searchHistoryList = <SearchHistoryModel>[].obs;

  //Vị trí trang Category (dung cho Dot Indicator)
  final RxInt currentPage = 0.obs;

  //Trạng thái Loading cho trang
  var isLoading = true.obs;

  //Gọi Service từ database
  final db = DatabaseService();

  ///----------------------
  /// Loading Data Function (Danh sách hàm để load và xử lý dữ liệu từ Firebase)
  ///----------------------
  @override
  void onInit() {
    super.onInit();
    loadUser();
    loadUsersAndMap();
    loadProducts();
    loadCategories();
    updateCategoryCounts();
  }

  //Hàm load thông tin User
  Future<void> loadUser() async {
    isLoading.value = true;
    final userData = await db.fetchDataCurrentUser();
    if (userData != null) {
      final u = UserModal.fromMap(userData);
      u.userId = FirebaseAuth.instance.currentUser?.uid; //set thủ công UID
      user.value = u;
    }
    isLoading.value = false;
  }

  //Hàm load thông tin danh sách toàn bộ User
  Future<void> loadUsersAndMap() async {
    final users = await db.getAllUsers();
    userList.assignAll(users);  

    // Cập nhật map ngay sau khi userList có dữ liệu
    userIdToUserName.clear();
    for (var u in users) {
      if (u.userId != null && u.fullName != null) {
        userIdToUserName[u.userId!] = u.fullName!;
      }
    }
    userIdToUserName.refresh(); // để Obx nhận thay đổi
  }

  //Hàm load thông tin danh sách Product
  Future<void> loadProducts() async {
    try {
      isLoading(true);
      var products = await db.getAllProducts();
      productList.assignAll(products);
    } catch (e) {
      print("Error loading products: $e");
    } finally {
      isLoading(false);
      updateCategoryCounts();
    }
  }

  //Hàm load danh sách Category, sắp xếp theo position tăng dần
  Future<void> loadCategories() async {
    try {
      isLoading(true);
      final categories = await db.getAllCategories();
      categories.sort((a, b) => a.position.compareTo(b.position));
      categoryList.assignAll(categories);
    } catch (e) {
      print('Error loading categories: $e');
    } finally {
      isLoading(false);
      updateCategoryCounts();
    }
  }

  void loadSearchHistory() {
    try {
      isLoading(true);
      final id = user.value?.userId;
      print("User ID is: $id");
      if (id == null) {
        print("User ID is null, cannot load search history");
        return;
      }

      db.getUserSearchHistory(id).listen((history) {
        searchHistoryList.assignAll(history);
      });
    } catch (e) {
      print("Error loading search history: $e");
    } finally {
      isLoading(false);
    }
  }

  //Hàm lấy tên user từ userId
  String getUserNameById(String? userId) {
    if (userId == null) return 'Unknown User';
    return userIdToUserName[userId] ?? 'Unknown User';
  }

  //Sau khi load categories và products xong, gọi hàm này để cập nhật count cho từng category
  void updateCategoryCounts() {
    if (categoryList.isEmpty || productList.isEmpty) {
      for (var cat in categoryList) {
        cat.count = 0;
      }
      categoryList.refresh();
      return;
    }

    Map<String, int> counts = {};

    for (var product in productList) {
      final categoriesOfProduct = product.categoryList ?? [];
      for (var catId in categoriesOfProduct) {
        if (counts.containsKey(catId)) {
          counts[catId] = counts[catId]! + 1;
        } else {
          counts[catId] = 1;
        }
      }
    }

    for (var cat in categoryList) {
      cat.count = counts[cat.name] ?? 0;
    }
    // print('Counts: $counts');

    categoryList.refresh();
  }

  ///------------------
  /// Sort Option Group (Logic phân loại, sắp xếp các sản phẩm theo Option Group)
  ///------------------

  //Hàm lấy dữ liệu khi chọn trong Option Group
  void changeSortOption(String option) {
    selectedSortOption.value = option;
  }

  //Hàm lọc + sắp xếp + giới hạn 10 sản phẩm
  List<ProductModel> getFilteredProducts() {
    List<ProductModel> sortedList = List.from(productList);

    switch (selectedSortOption.value) {
      case 'Newest':
        sortedList.sort((a, b) {
          DateTime dateA =
              DateTime.tryParse(a.createdAt ?? '') ?? DateTime(1970);
          DateTime dateB =
              DateTime.tryParse(b.createdAt ?? '') ?? DateTime(1970);
          return dateB.compareTo(dateA);
        });
        break;

      case 'High \$':
        sortedList.sort(
          (a, b) => (b.productPrice as num? ?? 0).compareTo(
            a.productPrice as num? ?? 0,
          ),
        );
        break;

      case 'Low \$':
        sortedList.sort(
          (a, b) => (a.productPrice as num? ?? 0).compareTo(
            b.productPrice as num? ?? 0,
          ),
        );
        break;
    }

    return sortedList.take(10).toList();
  }

  ///----------------------------------
  /// General GridView Product Function (Logic thị danh sách sản phẩm)
  ///----------------------------------

  //Lấy danh sách sản phẩm dựa trên category name
  List<ProductModel> getProductListByCategory(
    CategoryModel category,
    List<ProductModel> productList,
  ) {
    return productList.where((product) {
      final categories = product.categoryList ?? [];
      //Nếu trong product.categories chứa category.name thì giữ lại
      return categories.contains(category.name);
    }).toList();
  }

  ///-------------------------
  /// Search Product Function (Logic hiển thị và chức năng tìm kiểm)
  ///-------------------------

  //Lưu lại content mà người dùng Search để hiện thị làm gợi ý
  void saveSearchHistory(String searchContent) {
    //Không có searchContent thi trả về
    if (searchContent.trim().isEmpty) return;
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      Get.snackbar("Error", "You must be logged in to post a product");
      return;
    }

    final searchHistory = SearchHistoryModel(
      id: null, //Để tạo bằng Firebase
      searchContent: searchContent.trim(),
      userId: currentUser.uid,
      createdAt: Timestamp.now(),
    );

    db.addOrUpdateSearchHistory(searchHistory);
  }

  //Hàm xử lý logic tìm kiểm của ứng dụng sau khi người dùng insert keyword
  List<ProductModel> searchProducts(String keyword) {
    if (keyword.trim().isEmpty) return [];

    //Duyệt qua tất cả các phần đáp ứng các yêu cầu:
    return productList.where((product) {
      //Chuyển hết name, description và keyword sang chữ thường, giúp tìm kiếm không phân biệt hoa/thường.
      final name = (product.productName ?? '').toLowerCase();
      final description = (product.productDescription ?? '').toLowerCase();
      final query = keyword.toLowerCase();

      //Kiểm tra có chứa k
      return name.contains(query) || description.contains(query);
    }).toList();
  }
}
