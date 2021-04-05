import 'dart:typed_data';

import 'package:t_commerce_app/domain/model/model_type.dart';
import 'package:uuid/uuid.dart';

enum CategoryRowName {
  id,
  name,
  description,
  image,
}

extension CategoryRowNameExtension on CategoryRowName {
  String get name {
    switch (this) {
      case CategoryRowName.id:
        return "id";
      case CategoryRowName.name:
        return "name";
      case CategoryRowName.description:
        return "description";
      case CategoryRowName.image:
        return "image";
    }
  }
}

class Category implements ModelType {
  String id = Uuid().v4();
  String name = "";
  String description = "";
  Uint8List? image;

  Category(
      {required this.id,
      required this.name,
      required this.description,
      required this.image});

  Category.create(
      {required this.name, required this.description, required this.image});

  @override
  Map<String, dynamic> toMap() {
    return {
      CategoryRowName.id.name: id,
      CategoryRowName.name.name: name,
      CategoryRowName.description.name: description,
      CategoryRowName.image.name: image
    };
  }

  static Category fromMap(Map<String, dynamic> map) {
    return Category(
        id: map[CategoryRowName.id.name],
        name: map[CategoryRowName.name.name],
        description: map[CategoryRowName.description.name],
        image: map[CategoryRowName.image.name]);
  }
}
