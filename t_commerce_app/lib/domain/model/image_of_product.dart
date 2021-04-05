import 'dart:typed_data';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:t_commerce_app/domain/model/model_type.dart';
import 'package:uuid/uuid.dart';

enum ImageOfProductRowName {
  id,
  productId,
  image,
  isAvatar,
  identifier,
  name,
  originalWidth,
  originalHeight
}

extension ImageOfProductRowNameExtension on ImageOfProductRowName {
  String get name {
    switch (this) {
      case ImageOfProductRowName.id:
        return "id";
      case ImageOfProductRowName.productId:
        return "productId";
      case ImageOfProductRowName.image:
        return "image";
      case ImageOfProductRowName.isAvatar:
        return "isAvatar";
      case ImageOfProductRowName.identifier:
        return "identifier";
      case ImageOfProductRowName.name:
        return "name";
      case ImageOfProductRowName.originalWidth:
        return "originalWidth";
      case ImageOfProductRowName.originalHeight:
        return "originalHeight";
    }
  }
}

class ImageOfProduct extends ModelType {
  String id = Uuid().v4();
  String productId;
  Uint8List image;
  bool isAvatar;
  Asset? imageAsset;

  ImageOfProduct(
      {required this.id,
      required this.productId,
      required this.image,
      required this.isAvatar,
      required this.imageAsset});

  ImageOfProduct.create(
      {required this.productId,
      required this.image,
      required this.isAvatar,
      required this.imageAsset});

  @override
  Map<String, dynamic> toMap() {
    return {
      ImageOfProductRowName.id.name: id,
      ImageOfProductRowName.productId.name: productId,
      ImageOfProductRowName.image.name: image,
      ImageOfProductRowName.isAvatar.name: isAvatar ? 1 : 0,
      ImageOfProductRowName.identifier.name: imageAsset?.identifier,
      ImageOfProductRowName.name.name: imageAsset?.name,
      ImageOfProductRowName.originalWidth.name: imageAsset?.originalWidth,
      ImageOfProductRowName.originalHeight.name: imageAsset?.originalHeight,
    };
  }

  static ImageOfProduct fromMap(Map<String, dynamic> map) {
    return ImageOfProduct(
        id: map["id"],
        productId: map["productId"],
        image: map["image"],
        isAvatar: map["isAvatar"] as int == 0 ? false : true,
        imageAsset: Asset(
            map[ImageOfProductRowName.identifier.name],
            map[ImageOfProductRowName.name.name],
            map[ImageOfProductRowName.originalWidth.name],
            map[ImageOfProductRowName.originalHeight.name]));
  }
}
