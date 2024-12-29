import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:e_commerce_flutter/core/app_data.dart';
import 'package:e_commerce_flutter/src/model/product.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:e_commerce_flutter/src/model/product_category.dart';

class ProductController extends GetxController {
  List<Product> allProducts = AppData.products;
  RxList<Product> filteredProducts = AppData.products.obs;
  RxList<Product> cartProducts = <Product>[].obs;
  RxList<ProductCategory> categories = AppData.categories.obs;
  RxInt totalPrice = 0.obs;


  void filterItemsByCategory(int index) {
    for (ProductCategory element in categories) {
      element.isSelected = false;
    }
    categories[index].isSelected = true;
      // Lọc sản phẩm theo danh mục
    if (categories[index].type == ProductType.all) {
      // Nếu chọn "Tất cả", hiển thị tất cả sản phẩm
      filteredProducts.assignAll(allProducts);
    } else {
      // Nếu là một danh mục cụ thể, lọc theo loại sản phẩm
      filteredProducts.assignAll(allProducts.where((item) {
        return item.type == categories[index].type;
      }).toList());
    }
    update();// Cập nhật giao diện để phản ánh các thay đổi
  }

  //Thay đổi trạng thái sản phẩm yêu thích
  void isFavorite(int index) {
    filteredProducts[index].isFavorite = !filteredProducts[index].isFavorite;
    update();
  }

  // Thêm sản phẩm vào giỏ hàng
  void addToCart(Product product) {
    product.quantity++;
    cartProducts.add(product);
    cartProducts.assignAll(cartProducts);
    calculateTotalPrice();
  }

  // Tăng số lượng sản phẩm trong giỏ hàng
  void increaseItemQuantity(Product product) {
    product.quantity++;
    calculateTotalPrice();
    update();
  }

  // Giảm số lượng sản phẩm trong giỏ hàng
  void decreaseItemQuantity(Product product) {
    product.quantity--;
    calculateTotalPrice();
    update();
  }

  // Kiểm tra xem sản phẩm có giá ưu đãi hay không
  bool isPriceOff(Product product) => product.off != null;

  // Getter để kiểm tra xem giỏ hàng có trống hay không
  bool get isEmptyCart => cartProducts.isEmpty;

  // Tính tổng giá trong giỏ hàng
  void calculateTotalPrice() {
    totalPrice.value = 0;
    for (var element in cartProducts) {
      if (isPriceOff(element)) {
        totalPrice.value += element.quantity * element.off!;
      } else {
        totalPrice.value += element.quantity * element.price;
      }
    }
  }

  // Lấy danh sách sản phẩm yêu thích   
  getFavoriteItems() {
    filteredProducts.assignAll(
      allProducts.where((item) => item.isFavorite),
    );
  }

  // Lấy danh sách sản phẩm trong giỏ hàng
  getCartItems() {
    cartProducts.assignAll(
      allProducts.where((item) => item.quantity > 0),
    );
  }

  // Lấy tất cả sản phẩm
  getAllItems() {
    filteredProducts.assignAll(allProducts);
  }
}
