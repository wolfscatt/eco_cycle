import 'dart:io';
import 'dart:math';

import 'package:eco_cycle/src/domain/repositories/controller/home_controller.dart';
import 'package:eco_cycle/src/domain/usecases/helper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../presentation/pages/home_page.dart';
import '../../entities/category_enum.dart';
import '../../entities/photograf.dart';
import '../auth_repository.dart';
import '../photo_repository.dart';

class AddPhotoController extends GetxController {
  static AddPhotoController get to => Get.find();

  final ImagePicker _imagePicker = ImagePicker();
  final Rx<File?> selectedImage = Rx<File?>(null);
  final Rx<Category> selectedCategory = Category.plantTrees.obs;

  final TextEditingController descriptionController = TextEditingController();
  final _authRepo = Get.put(AuthenticationRepository());
  final _photoRepo = Get.put(PhotoRepository());

  final _storage = FirebaseStorage.instance;

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

  Future<void> saveImageData() async {
    if (selectedImage.value == null) {
      // Hata durumunda uyarı gösterilebilir
      return;
    }

    try {
      // Firebase Storage'a resim yükleme işlemi
      final userName = _authRepo.auth.currentUser;
      final fileName = selectedImage.value!.path.split('/').last;
      final Reference ref = _storage
          .ref()
          .child('Users/${userName?.displayName}/pictures/$fileName');
      await ref.putFile(selectedImage.value!);
      final imageUrl = await ref.getDownloadURL();

      // Cloud Firestore'a kaydetme
      final addedPhotoData = AddedPhotoData(
        id: userName!.uid,
        imageUri: imageUrl,
        category: selectedCategory.value,
        description: descriptionController.text,
        name: userName.displayName,
        imageId: fileName,
      );
      final result = await _photoRepo.uploadImageCloud(addedPhotoData);
      if (result == null) {
        Helper.successSnackBar(
            title: "Success", message: "Image uploaded successfully");

        Get.find<HomeController>().setPoint();
      }

      // Resim başarıyla yüklendi, burada imageUrl'i kullanabilirsiniz
    } catch (e) {
      // Hata durumunda uyarı gösterilebilir
      Helper.errorSnackBar(title: "Error", message: "Failed to upload image");
    }
  }

  Future<String?> deletePhoto(String imageid) async {
    if (imageid.isNotEmpty) {
      final ref = _storage.ref().child(
          'Users/${_authRepo.auth.currentUser?.displayName}/pictures/$imageid');
      await ref.delete();
      final result = await _photoRepo.deleteImageFromCloud(imageid);
      if (result != null) {
        return "Failed to delete photo";
      }
    }else{
      return "Image id is empty";
    }
  }
}
