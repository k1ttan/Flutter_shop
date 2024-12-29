import 'package:flutter/material.dart';
import 'package:e_commerce_flutter/core/app_data.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:e_commerce_flutter/src/view/screen/cart_screen.dart';
import 'package:e_commerce_flutter/src/view/screen/favorite_screen.dart';
import 'package:e_commerce_flutter/src/view/screen/product_list_screen.dart';
import 'package:e_commerce_flutter/src/view/animation/page_transition_switcher_wrapper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  // Danh sách các màn hình sẽ được hiển thị trong HomeScreen
  static const List<Widget> screens = [
    ProductListScreen(),
    FavoriteScreen(),
    CartScreen(),
  ];

  @override // Tạo trạng thái cho HomeScreen
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int newIndex = 0; // Biến để theo dõi chỉ số của màn hình hiện tại

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Scaffold(
          bottomNavigationBar: StylishBottomBar(
            currentIndex: newIndex,
            onTap: (index) {
              newIndex = index; // Cập nhật chỉ số mới khi người dùng nhấn vào mục
              setState(() {}); // Gọi setState để làm mới giao diện
            },
            items: AppData.bottomNavBarItems // Các mục cho thanh điều hướng
                .map(
                  (item) => BottomBarItem(
                    backgroundColor: item.activeColor,
                    icon: item.icon,
                    title: Text(
                      item.title,
                      style: TextStyle(
                        color: item.activeColor,
                      ),
                    ),
                  ),
                )
                .toList(),
            option: BubbleBarOptions(
              opacity: 0.3,
              unselectedIconColor: Colors.grey,
              borderRadius: BorderRadius.circular(
                15.0,
              ),
            ),
          ),
          // Nội dung của màn hình sẽ thay đổi tùy vào chỉ số newIndex
          body: PageTransitionSwitcherWrapper(
            child: HomeScreen.screens[newIndex], // Hiển thị màn hình dựa vào chỉ số
          ),
        ),
      ),
    );
  }
}
