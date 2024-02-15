import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eco_cycle/src/domain/repositories/controller/home_controller.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key, required this.controller,
  });
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: controller.currentIndex,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      animationDuration: Duration(milliseconds: 300),
      onTap: (index) {
        //print(index);
        controller.setPage(index);
        controller.setTitle();
      },
      items: [
        Icon(Icons.home, size: 30),
        Icon(Icons.add_a_photo, size: 30),
        Icon(Icons.shopping_cart, size: 30),
      ],
    );
  }
}
