import 'dart:io';

import 'package:eco_cycle/src/domain/usecases/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../entities/category_enum.dart';

class AddPhotoController extends GetxController {

  final ImagePicker _imagePicker = ImagePicker();
  final Rx<File?> selectedImage = Rx<File?>(null);
  final Rx<Category> selectedCategory = Category.plantTrees.obs;

  final TextEditingController descriptionController = TextEditingController();

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<void> getImageFromGallery() async {
    if (int.parse(Platform.version.split('.')[0]) >= 32) {
      await photosOrStoragePermissionRequest(Permission.photos);
    } else {
      await photosOrStoragePermissionRequest(Permission.storage);
    }
  }

  Future<void> photosOrStoragePermissionRequest(Permission permission) async {
    if (await _requestPermission(permission)) {
      final pickedFile =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
      // Burada pickedFile değişkeniyle seçilen fotoğrafın işlemlerini yapabilirsiniz

      } else {
        Helper.errorSnackBar(
            title: "Error", message: "Failed to pick an image");
      }
    } else {
      Helper.errorSnackBar(
          title: "Permission Denied",
          message: "Please grant access to the gallery");
    }
  }

  Future<void> getImageFromCamera() async {
    if (await _requestPermission(Permission.camera)) {
      final pickedFile =
          await _imagePicker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
      } else {
        Helper.errorSnackBar(title: "Error", message: "Failed to take a photo");
      }
      // Burada pickedFile değişkeniyle çekilen fotoğrafın işlemlerini yapabilirsiniz
    } else {
      Helper.errorSnackBar(
          title: "Permission Denied",
          message: "Please grant access to the camera");
    }
  }


  Widget descriptionWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: descriptionController,
        decoration: InputDecoration(
          labelText: "Description",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        maxLines: 3,
      ),
    );
  }

  Widget dropDownButtonWidget() {
    return Obx(() {
    print(selectedCategory.value.toString().split(".").last);
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              10), // İstediğiniz border radius değerini burada belirleyebilirsiniz
          border: Border.all(
              color: Colors
                  .black), // Kenar çizgisinin rengini ve kalınlığını buradan ayarlayabilirsiniz
        ),
        child: DropdownButton<Category>(
          value: selectedCategory.value,
          onChanged: (Category? newValue) {
            selectedCategory.value = newValue!;
          },
          items:
              Category.values.map<DropdownMenuItem<Category>>((Category value) {
            return DropdownMenuItem<Category>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical:
                        8), // Metnin içeriği ile çerçeve arasında boşluk ayarlamak için kullanılır
                child: Text(value.toString().toUpperCase().split('.').last),
              ),
            );
          }).toList(),
        ),
      );
    });
  }

  Widget image() {
    return Obx(() {
      if (selectedImage.value != null) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.file(
              selectedImage.value!,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        );
      } else {
        return Icon(Icons.image, size: 200, color: Colors.grey);
      }
    });
  }

  Future<void> showCustomBottomSheet() async {
    Get.bottomSheet(
      Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                leading: Icon(Icons.photo),
                title: Text(
                  'Select from Gallery',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Get.back();
                  getImageFromGallery();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Take a Photo',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                onTap: () {
                  Get.back();
                  getImageFromCamera();
                },
              ),
            ],
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      backgroundColor: Colors.transparent, // Arkaplanı saydam yapar
      barrierColor: Colors.black.withOpacity(0.5), // Arkaplanı koyulaştırır
      isDismissible: true, // Dokunarak kapatmayı etkinleştirir
      enableDrag: true, // Sürükleyerek kapatmayı etkinleştirir
    );
  }

  void saveImageData() {
    // mevcut kullanıcının dosyaları altına photograf modelini kullanan verileri kaydedeceğiz. ve kayıt sonunda başarılı ya da başarısz olma durumuna göre snackbar göstereceğiz. Home Page'de ise kullanıcı kendi kaydettiğini resimleri, açıklamalarını ve puanını bir kart içerisinde yan yana 2 resim sığacak şekilde görebilecek. Card'a tıkladığında resmin detaylarının olduğu bir sayfa açılacak ve orada isterse resmi silebilecek. Storage'da her kullanıcı için Users/userName/pictures klasörü altına resimler kayıt edilecek.

  }
}
