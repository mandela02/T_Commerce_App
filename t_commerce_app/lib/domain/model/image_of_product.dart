import 'dart:typed_data';

import 'package:t_commerce_app/domain/model/model_type.dart';
import 'package:uuid/uuid.dart';

class ImageOfProduct extends ModelType {
  String id = Uuid().v4();
  String productId;
  Uint8List image;
  bool isAvatar;

  ImageOfProduct(
      {required this.id,
      required this.productId,
      required this.image,
      required this.isAvatar});

  ImageOfProduct.create(
      {required this.productId, required this.image, required this.isAvatar});

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "productId": productId,
      "image": image,
      "isAvatar": isAvatar ? 1 : 0
    };
  }

  static ImageOfProduct fromMap(Map<String, dynamic> map) {
    return ImageOfProduct(
        id: map["id"],
        productId: map["productId"],
        image: map["image"],
        isAvatar: map["isAvatar"] as int == 0 ? false : true);
  }
}
