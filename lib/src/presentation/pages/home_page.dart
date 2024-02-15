import 'package:eco_cycle/src/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/repositories/controller/home_controller.dart';
import '../widgets/bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      appBar: CustomAppBar(
        controller: controller,
        leading: HomeLeadingWidget(),
      ),
      body: Obx(() => controller.getBodyWidget()),
      bottomNavigationBar: CustomBottomNavBar(
        controller: controller,
      ),
    );
  }
}

class HomePageBodyWidget extends StatelessWidget {
  const HomePageBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: 2,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                color: Colors.grey[300],
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      "https://cdn.pixabay.com/photo/2023/09/25/12/41/desert-8274886_1280.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          },
      );
  }
}

class HomeLeadingWidget extends StatelessWidget {
  const HomeLeadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Icon(
            Icons.stars_rounded,
            color: Colors.black,
          ),
          Text(
            "500",
            style: TextStyle(
                color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
