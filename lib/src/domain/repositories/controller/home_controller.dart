import 'package:eco_cycle/src/presentation/pages/add_photo_page.dart';
import 'package:eco_cycle/src/presentation/pages/shop_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../presentation/pages/home_page.dart';

class HomeController extends GetxController {
  final _currentIndex = 0.obs;
  final _currentTitle = "Home".obs;

  int get currentIndex => _currentIndex.value;
  String get currentTitle => _currentTitle.value;

  void setTitle() {
    switch (_currentIndex.value) {
      case 0:
        _currentTitle.value = "Home";
      case 1:
        _currentTitle.value = "Add Photo";
      case 2:
        _currentTitle.value = "Shop";
      default:
        _currentTitle.value = "Home";
    }
  }

  Widget getBodyWidget() {
    print(_currentIndex.value);
    switch (_currentIndex.value) {
      case 0:
        return HomePageBodyWidget();
      case 1:
        return AddPhotoPage();
      case 2:
        return ShopPage();
      default:
        return HomePageBodyWidget();
    }
  }

  void setPage(int index) {
    _currentIndex.value = index;
  }
}
