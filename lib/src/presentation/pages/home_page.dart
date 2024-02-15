import 'package:eco_cycle/src/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/photograf.dart';
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
    final controller = Get.put(HomeController());
    return FutureBuilder<List<AddedPhotoData>>(
        future: controller.fetchPhotos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final photos = snapshot.data;
            if (photos == null || photos.isEmpty) {
              return Center(child: Text('No photos found.'));
            }
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: photos.length,
              itemBuilder: (context, index) {
                final photo = photos[index];
                return GestureDetector(
                  onTap: () => _showPhotoDialog(context, photo),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                            child: Image.network(
                              photo.imageUri,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Category: ${photo.category.toString().split('.').last}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Description: ${photo.description ?? ''}',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _showDeleteConfirmationDialog(
                              context, photo, controller),
                          child: Text('Delete'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
    );
  }

  void _showPhotoDialog(BuildContext context, AddedPhotoData photo) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              photo.imageUri,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category: ${photo.category.toString().split('.').last}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Description: ${photo.description ?? ''}',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, AddedPhotoData photo, HomeController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Photo'),
        content: Text('Are you sure you want to delete this photo?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              controller.deletePhoto(photo.imageId);
              Navigator.pop(context);
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}