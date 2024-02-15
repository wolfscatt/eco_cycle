import 'package:eco_cycle/src/domain/repositories/controller/add_photo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPhotoPage extends StatelessWidget {
  const AddPhotoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddPhotoController());
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: controller.image(),
            ),
            SizedBox(height: 20,),
            controller.dropDownButtonWidget(),
            SizedBox(height: 20,),
            controller.descriptionWidget(),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: (){
                    controller.showCustomBottomSheet();
                  },
                  child: Text("Select Image")),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: (){
                    // Firebase'e kaydetme işlemi yapılacak.
                    controller.saveImageData();
                  },
                  child: Text("Save Image")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
