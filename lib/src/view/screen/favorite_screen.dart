import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_flutter/src/view/screen/cart_screen.dart';
import 'package:e_commerce_flutter/src/controller/product_controller.dart';
import 'package:e_commerce_flutter/src/view/widget/product_grid_view.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getFavoriteItems(); // Gọi phương thức để lấy danh sách sản phẩm yêu thích
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorites",
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GetBuilder(
          // Hàm builder nhận đối tượng controller
          builder: (ProductController controller) {
            return ProductGridView(
              // Truyền danh sách sản phẩm đã được lọc vào widget ProductGridView
              items: controller.filteredProducts,
              // Xử lý khi nhấn vào nút yêu thích
              likeButtonPressed: (index) => controller.isFavorite(index),
              // Kiểm tra xem giá của sản phẩm có ưu đãi hay không
              isPriceOff: (product) => controller.isPriceOff(product),
            );
          },
        ),
      ),
    );
  }
}
