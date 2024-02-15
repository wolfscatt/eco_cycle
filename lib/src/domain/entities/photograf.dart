import 'package:eco_cycle/src/domain/entities/category_enum.dart';

class AddedPhotoData {
  final String id;
  final String? name;
  final String imageUri;
  final Category category;
  final String? description;

  AddedPhotoData({required this.id, this.name, required this.imageUri, required this.category, this.description});

  
}
