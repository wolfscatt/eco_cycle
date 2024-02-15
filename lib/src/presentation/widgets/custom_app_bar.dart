import 'package:eco_cycle/src/domain/repositories/controller/home_controller.dart';
import 'package:eco_cycle/src/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final HomeController controller;

  const CustomAppBar({
    this.leading,
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Obx(
        () => Text(
          controller.currentTitle,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Colors.black),
        ),
      ),
      centerTitle: true,
      leading: leading,
      actions: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.blue),
          child: IconButton(
              onPressed: () {
                print("Profile Page");
                Get.to(() => ProfilePage());
              },
              icon: Icon(Icons.person_4_outlined)),
        )
      ],
      // İstediğiniz diğer özellikleri de buraya ekleyebilirsiniz
      // Örneğin: backgroundColor, elevation vb.
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
