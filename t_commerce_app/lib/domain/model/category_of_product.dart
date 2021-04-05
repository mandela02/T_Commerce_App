import 'package:t_commerce_app/domain/model/model_type.dart';
import 'package:uuid/uuid.dart';

enum CategoryOfProductRowName {
  id,
  categoryId,
  productId,
}

extension CategoryOfProductRowNameExtension on CategoryOfProductRowName {
  String get name {
    switch (this) {
      case CategoryOfProductRowName.id:
        return "id";
      case CategoryOfProductRowName.categoryId:
        return "categoryId";
      case CategoryOfProductRowName.productId:
        return "productId";
    }
  }
}

class CategoryOfProduct implements ModelType {
  String id = Uuid().v4();
  String categoryId = "";
  String productId = "";

  CategoryOfProduct(this.id,
      {required this.categoryId, required this.productId});

  CategoryOfProduct.create({required this.categoryId, required this.productId});

  @override
  Map<String, dynamic> toMap() {
    return {
      CategoryOfProductRowName.id.name: id,
      CategoryOfProductRowName.categoryId.name: categoryId,
      CategoryOfProductRowName.productId.name: productId,
    };
  }

  static CategoryOfProduct fromMap(Map<String, dynamic> map) {
    return CategoryOfProduct(map[CategoryOfProductRowName.id.name],
        categoryId: map[CategoryOfProductRowName.categoryId.name],
        productId: map[CategoryOfProductRowName.productId.name]);
  }
}
