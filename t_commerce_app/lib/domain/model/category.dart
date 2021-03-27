import 'package:t_commerce_app/domain/model/model_type.dart';
import 'package:uuid/uuid.dart';

class Category implements ModelType {
  String id = Uuid().v4();
  String name = "";
  String description = "";

  Category({required this.id, required this.name, required this.description});

  Category.create({required this.name, required this.description}) {
    this.id = Uuid().v4();
    this.name = name;
    this.description = description;
  }

  @override
  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "description": description};
  }

  static Category fromMap(Map<String, dynamic> map) {
    return Category(
        id: map["id"], name: map["name"], description: map["description"]);
  }
}
