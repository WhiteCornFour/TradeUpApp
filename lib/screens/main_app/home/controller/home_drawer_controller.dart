import 'package:get/get.dart';
import 'package:tradeupapp/models/product_model.dart';
import 'package:tradeupapp/screens/main_app/home/controller/home_controller.dart';

class HomeDrawerController extends GetxController {
  /// ----------
  /// Controller
  /// ----------
  
  final homeController = Get.find<HomeController>();

  /// ---------
  /// Variables
  /// ---------

  //Keyword
  var searchKeyword = ''.obs;

  //Category
  var selectedCategories = <String>[].obs;

  //Price
  var minPrice = 0.0.obs;
  var maxPrice = 0.0.obs;

  //Condition
  var selectedCondition = ''.obs;


  //Danh sách kết quả tìm kiếm
  var filteredProducts = <ProductModel>[].obs;

  //Hàm search theo Filter
  void searchProductsWithFilters() {
    //Bước 1: Bắt đầu từ danh sách gốc
    var results = homeController.productList.toList();

    //Bước 2: Lọc theo từ khoá
    if (searchKeyword.isNotEmpty) {
      results = results
          .where(
            (p) => (p.productName?.toLowerCase() ?? '').contains(
              searchKeyword.toLowerCase(),
            ),
          )
          .toList()
          .obs;
    }

    //Bước 3: Lọc theo danh mục
    if (selectedCategories.isNotEmpty) {
      results = results.where((p) {
        final categories = p.categoryList ?? [];
        return categories.any((cat) => selectedCategories.contains(cat));
      }).toList();
    }

    //Bước 4: Lọc theo khoảng giá
    if (minPrice.value > 0 || maxPrice.value > 0) {
      results = results.where((p) {
        final price = p.productPrice ?? 0;
        final matchMin = minPrice.value == 0 || price >= minPrice.value;
        final matchMax = maxPrice.value == 0 || price <= maxPrice.value;
        return matchMin && matchMax;
      }).toList();
    }

    //Bước 5: Lọc theo condition
    if (selectedCondition.isNotEmpty) {
      results = results
          .where(
            (p) =>
                (p.selectedCondition?.toLowerCase() ?? '') ==
                selectedCondition.value.toLowerCase(),
          )
          .toList();
    }

    //Bước 6: Gán kết quả
    filteredProducts.assignAll(results);
  }
}
