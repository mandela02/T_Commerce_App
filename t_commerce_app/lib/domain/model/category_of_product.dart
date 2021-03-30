import 'package:t_commerce_app/domain/model/model_type.dart';
import 'package:uuid/uuid.dart';

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
      "id": id,
      "categoryId": categoryId,
      "productId": productId,
    };
  }

  static CategoryOfProduct fromMap(Map<String, dynamic> map) {
    return CategoryOfProduct(map["id"],
        categoryId: map["categoryId"], productId: map["productId"]);
  }
}
