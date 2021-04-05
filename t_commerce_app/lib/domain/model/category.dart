import 'dart:typed_data';

import 'package:t_commerce_app/domain/model/model_type.dart';
import 'package:uuid/uuid.dart';

enum CategoryRowName {
  id,
  categoryName,
  description,
  memoryImage,
}

extension CategoryRowNameExtension on CategoryRowName {
  String get name {
    switch (this) {
      case CategoryRowName.id:
        return "id";
      case CategoryRowName.categoryName:
        return "categoryName";
      case CategoryRowName.description:
        return "description";
      case CategoryRowName.memoryImage:
        return "memoryImage";
    }
  }
}

class Category implements ModelType {
  String id = Uuid().v4();
  String categoryName = "";
  String description = "";
  Uint8List? memoryImage;

  Category(
      {required this.id,
      required this.categoryName,
      required this.description,
      required this.memoryImage});

  Category.create(
      {required this.categoryName,
      required this.description,
      required this.memoryImage});

  @override
  Map<String, dynamic> toMap() {
    return {
      CategoryRowName.id.name: id,
      CategoryRowName.categoryName.name: categoryName,
      CategoryRowName.description.name: description,
      CategoryRowName.memoryImage.name: memoryImage
    };
  }

  static Category fromMap(Map<String, dynamic> map) {
    return Category(
        id: map[CategoryRowName.id.name],
        categoryName: map[CategoryRowName.categoryName.name],
        description: map[CategoryRowName.description.name],
        memoryImage: map[CategoryRowName.memoryImage.name]);
  }
}
