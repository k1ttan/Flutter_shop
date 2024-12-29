import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:e_commerce_flutter/src/model/product_category.dart';

class ListItemSelector extends StatefulWidget {
  const ListItemSelector({
    super.key,
    required this.categories,
    required this.onItemPressed,
  });

  final List<ProductCategory> categories;
  final Function(int) onItemPressed; // Hàm callback nhận vào chỉ số của mục được nhấn

  @override // Tạo trạng thái cho ListItemSelector
  State<ListItemSelector> createState() => _ListItemSelectorState(); 
}

class _ListItemSelectorState extends State<ListItemSelector> {
  Widget item(ProductCategory item, int index) {
    return Tooltip( 
      // Hiển thị Tooltip với tên loại sản phẩm
      message: item.type.name.capitalizeFirst, 
      child: AnimatedContainer(
        margin: const EdgeInsets.only(left: 5),
        duration: const Duration(milliseconds: 500),
        width: 50,
        height: 100,
        decoration: BoxDecoration(
          color: item.isSelected == false
              ? const Color(0xFFE5E6E8)
              : const Color(0xFFf16b26),
          borderRadius: BorderRadius.circular(10),
        ),
        child: IconButton(
          splashRadius: 0.1,
          icon: FaIcon(
            item.icon,
            color: item.isSelected == false
                ? const Color(0xFFA6A3A0)
                : Colors.white,
          ),
          onPressed: () {
          // Gọi hàm callback với chỉ số của mục nhấn
            widget.onItemPressed(index);
            for (var element in widget.categories) {
          // Thiết lập trạng thái isSelected của tất cả các mục là false
              element.isSelected = false;
            }

            item.isSelected = true;
            setState(() {});
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        // Gọi phương thức item để tạo widget cho từng mục
        itemBuilder: (_, index) => item(widget.categories[index], index),
      ),
    );
  }
}
