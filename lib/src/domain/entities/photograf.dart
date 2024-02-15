import 'package:eco_cycle/src/domain/entities/category_enum.dart';

class AddedPhotoData {
  final String id;
  final String? name;
  final String imageUri;
  final Category category;
  final String? description;
  final String imageId;

  AddedPhotoData({
    required this.id, 
    this.name, 
    required this.imageUri, 
    required this.category, 
    this.description, 
    required this.imageId});

  // JSON'dan AddedPhotoData nesnesine dönüştürme metodu
  factory AddedPhotoData.fromJson(Map<String, dynamic> json) {
    return AddedPhotoData(
      id: json['id'],
      name: json['name'],
      imageUri: json['imageUri'],
      category: Category.values.firstWhere((e) => e.toString().split('.').last == json['category']),
      description: json['description'],
      imageId: json['imageId'],
    );
  }

  // AddedPhotoData nesnesini JSON'a dönüştürme metodu
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUri': imageUri,
      'category': category.toString().split('.').last,
      'description': description,
      'imageId': imageId,
    };
  }
}
