import 'package:eco_cycle/src/domain/entities/category_enum.dart';

class Photograf {
  final String id;
  final String name;
  final String imageUri;
  final Category category;
  final String description;

  Photograf({required this.id, required this.name, required this.imageUri, required this.category, required this.description});

  
}
