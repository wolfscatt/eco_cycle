import 'package:eco_cycle/src/domain/repositories/controller/add_photo_controller.dart';
import 'package:eco_cycle/src/domain/usecases/helper.dart';
import 'package:eco_cycle/src/presentation/pages/add_photo_page.dart';
import 'package:eco_cycle/src/presentation/pages/shop_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../presentation/pages/home_page.dart';
import '../../entities/photograf.dart';
import '../photo_repository.dart';

class HomeController extends GetxController {
  final _currentIndex = 0.obs;
  final _currentTitle = "Home".obs;
  final _currentPoint = 100.obs;

  int get currentPoint => _currentPoint.value;
  int get currentIndex => _currentIndex.value;
  String get currentTitle => _currentTitle.value;

  final _photoRepo = Get.put(PhotoRepository());
  final _addPhotoController = Get.put(AddPhotoController());

  void setPoint(){
    _currentPoint.value += 100;
  }

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

  Future<List<AddedPhotoData>> fetchPhotos() async {
    final photos = await _photoRepo.readImageFromCloud();
    return photos;
  }

  deletePhoto(String imageUri) async {
    final result = await _addPhotoController.deletePhoto(imageUri);
    if (result != null) {
      Helper.errorSnackBar(title: "Error", message: "Failed to delete photo");
    } else {
      Helper.warningSnackBar(
          title: "Success", message: "Photo deleted successfully");
      setPage(6);
    }
  }
}
