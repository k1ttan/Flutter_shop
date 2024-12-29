import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_flutter/src/model/product.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:e_commerce_flutter/src/view/widget/carousel_slider.dart';
import 'package:e_commerce_flutter/src/controller/product_controller.dart';

final ProductController controller = Get.put(ProductController());

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen(this.product, {super.key});

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back, color: Colors.black),
      ),
    );
  }

  // Phương thức tạo view cho hình ảnh sản phẩm
  Widget productPageView(double width, double height) {
    return Container(
      height: height * 0.42,
      width: width,
      decoration: const BoxDecoration(
        color: Color(0xFFE5E6E8),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(200),
          bottomLeft: Radius.circular(200),
        ),
      ),
      child: CarouselSlider(items: product.images),
    );
  }

  //tạo bar đánh giá sản phẩm
  Widget _ratingBar(BuildContext context) {
    return Wrap(
      spacing: 30,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        RatingBar.builder(
          // Đánh giá ban đầu từ sản phẩm
          initialRating: product.rating,
          // Hiển thị đánh giá theo hướng ngang
          direction: Axis.horizontal,
          itemBuilder: (_, __) => const FaIcon(
            FontAwesomeIcons.solidStar,
            color: Colors.amber,
          ),
          onRatingUpdate: (_) {}, // Xử lý cập nhật điểm đánh giá
        ),
        Text(
          "(4500 Reviews)",
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w300,
              ),
        )
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    // Lấy chiều cao màn hình
    double height = MediaQuery.of(context).size.height;
    // Lấy chiều rộng màn hình
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _appBar(context),
        body: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hiển thị hình ảnh sản phẩm
                  productPageView(width, height),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const SizedBox(height: 10),
                        // Hiển thị bar đánh giá
                        _ratingBar(context),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              // Hiển thị giá ưu đãi hoặc giá gốc
                              product.off != null ? "${product.off} đ" : "${product.price} đ",
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            const SizedBox(width: 3),
                            Visibility(
                              // Kiểm tra xem có giá giảm hay không
                              visible: product.off != null ? true : false,
                              child: Text(
                                // Giá gốc
                                "${product.price} đ",
                                style: const TextStyle(
                                  // Gạch ngang cho giá gốc
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              // Hiển thị trạng thái hàng
                              product.isAvailable ? "Còn hàng" : "Hết Hàng",
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                        Text(
                          "Mô tả về sản phẩm",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 10),
                        // Hiển thị mô tả chi tiết của sản phẩm
                        Text(product.about),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            // Thêm vào giỏ hàng nếu sản phẩm có sẵn
                            onPressed: product.isAvailable ? () => controller.addToCart(product) : null,
                            child: const Text("Thêm vào giỏ hàng"),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
