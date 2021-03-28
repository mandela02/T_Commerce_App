import 'dart:typed_data';

import 'package:t_commerce_app/domain/model/model_type.dart';
import 'package:uuid/uuid.dart';

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
      {required this.name, required this.description, required this.image}) {
    this.id = Uuid().v4();
    this.name = name;
    this.description = description;
    this.image = image;
  }

  @override
  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "description": description, "image": image};
  }

  static Category fromMap(Map<String, dynamic> map) {
    return Category(
        id: map["id"],
        name: map["name"],
        description: map["description"],
        image: map["image"]);
  }
}
