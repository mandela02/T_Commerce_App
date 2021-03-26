import 'package:t_commerce_app/domain/model/model_type.dart';
import 'package:uuid/uuid.dart';

class Category implements ModelType {
  String id = Uuid().v4();
  String name = "";

  Category({required this.id, required this.name});

  Category.create({required this.name}) {
    this.id = Uuid().v4();
    this.name = name;
  }

  @override
  Map<String, dynamic> toMap() {
    return {"id": id, "name": name};
  }

  static Category fromMap(Map<String, dynamic> map) {
    return Category(id: map["id"], name: map["name"]);
  }
}
