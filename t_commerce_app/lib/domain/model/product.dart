import 'package:t_commerce_app/domain/model/model_type.dart';
import 'package:uuid/uuid.dart';

enum ProductRowName {
  id,
  name,
  originalPrice,
  discountPrice,
  createDate,
  updateDate,
  barCode,
  description
}

extension ProductRowNameExtension on ProductRowName {
  String get name {
    switch (this) {
      case ProductRowName.id:
        return "id";
      case ProductRowName.name:
        return "name";
      case ProductRowName.originalPrice:
        return "originalPrice";
      case ProductRowName.discountPrice:
        return "discountPrice";
      case ProductRowName.createDate:
        return "createDate";
      case ProductRowName.updateDate:
        return "updateDate";
      case ProductRowName.barCode:
        return "barCode";
      case ProductRowName.description:
        return "description";
    }
  }
}

class Product implements ModelType {
  String id = Uuid().v4();
  String name = "";

  int originalPrice = 0;
  int discountPrice = 0;

  int createDate = 0;
  int updateDate = 0;
  String barCode = "";

  String description = "";

  Product(
      {required this.id,
      required this.name,
      required this.originalPrice,
      required this.discountPrice,
      required this.createDate,
      required this.updateDate,
      required this.barCode,
      required this.description});

  Product.create(
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
      ProductRowName.id.name: id,
      ProductRowName.name.name: name,
      ProductRowName.originalPrice.name: originalPrice,
      ProductRowName.discountPrice.name: discountPrice,
      ProductRowName.createDate.name: createDate,
      ProductRowName.updateDate.name: updateDate,
      ProductRowName.barCode.name: barCode,
      ProductRowName.description.name: description,
    };
  }

  static Product fromMap(Map<String, dynamic> map) {
    return Product(
        id: map[ProductRowName.id.name],
        name: map[ProductRowName.name.name],
        originalPrice: map[ProductRowName.originalPrice.name],
        discountPrice: map[ProductRowName.discountPrice.name],
        createDate: map[ProductRowName.createDate.name],
        updateDate: map[ProductRowName.updateDate.name],
        barCode: map[ProductRowName.barCode.name],
        description: map[ProductRowName.description.name]);
  }
}
