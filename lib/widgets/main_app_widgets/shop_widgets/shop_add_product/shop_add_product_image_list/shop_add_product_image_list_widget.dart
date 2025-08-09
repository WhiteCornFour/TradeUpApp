import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/screens/main_app/shop/shop_add_product/controller/shop_add_product_controller.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_add_product/shop_add_product_image_list/shop_add_product_image_picker_box_widget.dart';

class AddProductImageListShop extends StatelessWidget {
  const AddProductImageListShop({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = AddProductController.instance;
      final imgs = controller.imageList;

      return Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          //Hiển thị ảnh đã chọn
          for (int i = 0; i < imgs.length; i++)
            Stack(
              children: [
                //Ô ảnh
                AddProductImagePickerBoxShop(
                  size: 100,
                  borderRadius: 12,
                  image: FileImage(imgs[i]),
                  onTap: () {
                    //Nếu muốn đổi ảnh thì mở picker
                    controller.showImagePickerBottomSheet(context);
                  },
                ),
                //Nút X để xóa
                Positioned(
                  right: 3,
                  top: 3,
                  child: GestureDetector(
                    onTap: () => controller.removeImageAt(i),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.close, color: Colors.white, size: 16),
                    ),
                  ),
                ),
                //Tag "Cover" cho ảnh đầu tiên
                if (i == 0)
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          topRight: Radius.circular(6),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      child: const Text(
                        "Cover",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Roboto-Bold',
                        ),
                      ),
                    ),
                  ),
              ],
            ),

          //Ô trống để thêm ảnh mới (chỉ hiển thị nếu chưa đủ 5 ảnh)
          if (imgs.length < 5)
            AddProductImagePickerBoxShop(
              size: 100,
              iconSize: 30,
              iconColor: AppColors.background,
              onTap: () {
                controller.showImagePickerBottomSheet(context);
              },
            ),
        ],
      );
    });
  }
}
