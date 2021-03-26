import 'package:t_commerce_app/domain/model/model_type.dart';
import 'package:uuid/uuid.dart';

class Product implements ModelType {
  String id = Uuid().v4();
  String name = "";

  int originalPrice = 0;
  int discountPrice = 0;

  int createDate = 0;
  int updateDate = 0;
  String barCode = "";

  String description = "";

  Product(this.id,
      {required this.name,
      required this.originalPrice,
      required this.discountPrice,
      required this.createDate,
      required this.updateDate,
      required this.barCode,
      required this.description});

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "originalPrice": originalPrice,
      "discountPrice": discountPrice,
      "createDate": createDate,
      "updateDate": updateDate,
      "barCode": barCode,
      "description": description,
    };
  }

  static Product fromMap(Map<String, dynamic> map) {
    return Product(map["id"],
        name: map["name"],
        originalPrice: map["originalPrice"],
        discountPrice: map["discountPrice"],
        createDate: map["createDate"],
        updateDate: map["updateDate"],
        barCode: map["barCode"],
        description: map["description"]);
  }
}
