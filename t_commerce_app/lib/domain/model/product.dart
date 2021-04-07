import 'package:t_commerce_app/domain/model/model_type.dart';
import 'package:uuid/uuid.dart';

enum ProductRowName {
  id,
  name,
  sellPrice,
  discountPrice,
  importPrice,
  createDate,
  updateDate,
  barCode,
  description,
  weight,
  quantity,
  unit,
}

extension ProductRowNameExtension on ProductRowName {
  String get name {
    switch (this) {
      case ProductRowName.id:
        return "id";
      case ProductRowName.name:
        return "name";
      case ProductRowName.sellPrice:
        return "sellPrice";
      case ProductRowName.discountPrice:
        return "discountPrice";
      case ProductRowName.importPrice:
        return "importPrice";
      case ProductRowName.createDate:
        return "createDate";
      case ProductRowName.updateDate:
        return "updateDate";
      case ProductRowName.barCode:
        return "barCode";
      case ProductRowName.description:
        return "description";
      case ProductRowName.weight:
        return "weight";
      case ProductRowName.quantity:
        return "quantity";
      case ProductRowName.unit:
        return "unit";
    }
  }
}

class Product implements ModelType {
  String id = Uuid().v4();
  String name = "";

  int sellPrice;
  int? discountPrice;
  int importPrice;

  int createDate;
  int updateDate;
  String? barCode;

  String description = "";

  int weight;
  int quantity;
  String unit;

  Product(
      {required this.id,
      required this.name,
      required this.sellPrice,
      required this.discountPrice,
      required this.importPrice,
      required this.createDate,
      required this.updateDate,
      required this.barCode,
      required this.description,
      required this.weight,
      required this.quantity,
      required this.unit});

  Product.create(
      {required this.name,
      required this.sellPrice,
      required this.discountPrice,
      required this.importPrice,
      required this.createDate,
      required this.updateDate,
      required this.barCode,
      required this.description,
      required this.weight,
      required this.quantity,
      required this.unit});

  @override
  Map<String, dynamic> toMap() {
    return {
      ProductRowName.id.name: id,
      ProductRowName.name.name: name,
      ProductRowName.sellPrice.name: sellPrice,
      ProductRowName.discountPrice.name: discountPrice,
      ProductRowName.importPrice.name: importPrice,
      ProductRowName.createDate.name: createDate,
      ProductRowName.updateDate.name: updateDate,
      ProductRowName.barCode.name: barCode,
      ProductRowName.description.name: description,
      ProductRowName.weight.name: weight,
      ProductRowName.quantity.name: quantity,
      ProductRowName.unit.name: unit,
    };
  }

  static Product fromMap(Map<String, dynamic> map) {
    return Product(
        id: map[ProductRowName.id.name],
        name: map[ProductRowName.name.name],
        sellPrice: map[ProductRowName.sellPrice.name],
        discountPrice: map[ProductRowName.discountPrice.name],
        importPrice: map[ProductRowName.importPrice.name],
        createDate: map[ProductRowName.createDate.name],
        updateDate: map[ProductRowName.updateDate.name],
        barCode: map[ProductRowName.barCode.name],
        description: map[ProductRowName.description.name],
        weight: map[ProductRowName.weight.name],
        quantity: map[ProductRowName.quantity.name],
        unit: map[ProductRowName.unit.name]);
  }
}
