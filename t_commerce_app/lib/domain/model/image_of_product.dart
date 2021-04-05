import 'dart:typed_data';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:t_commerce_app/domain/model/model_type.dart';
import 'package:uuid/uuid.dart';

enum ImageOfProductRowName {
  id,
  productId,
  memoryImage,
  isAvatar,
  assetIdentifier,
  assetName,
  assetOriginalWidth,
  assetOriginalHeight
}

extension ImageOfProductRowNameExtension on ImageOfProductRowName {
  String get name {
    switch (this) {
      case ImageOfProductRowName.id:
        return "id";
      case ImageOfProductRowName.productId:
        return "productId";
      case ImageOfProductRowName.memoryImage:
        return "memoryImage";
      case ImageOfProductRowName.isAvatar:
        return "isAvatar";
      case ImageOfProductRowName.assetIdentifier:
        return "assetIdentifier";
      case ImageOfProductRowName.assetName:
        return "assetName";
      case ImageOfProductRowName.assetOriginalWidth:
        return "assetOriginalWidth";
      case ImageOfProductRowName.assetOriginalHeight:
        return "assetOriginalHeight";
    }
  }
}

class ImageOfProduct extends ModelType {
  String id = Uuid().v4();
  String productId;
  Uint8List memoryImage;
  bool isAvatar;
  Asset? assetImage;

  ImageOfProduct(
      {required this.id,
      required this.productId,
      required this.memoryImage,
      required this.isAvatar,
      required this.assetImage});

  ImageOfProduct.create(
      {required this.productId,
      required this.memoryImage,
      required this.isAvatar,
      required this.assetImage});

  @override
  Map<String, dynamic> toMap() {
    return {
      ImageOfProductRowName.id.name: id,
      ImageOfProductRowName.productId.name: productId,
      ImageOfProductRowName.memoryImage.name: memoryImage,
      ImageOfProductRowName.isAvatar.name: isAvatar ? 1 : 0,
      ImageOfProductRowName.assetIdentifier.name: assetImage?.identifier,
      ImageOfProductRowName.assetName.name: assetImage?.name,
      ImageOfProductRowName.assetOriginalWidth.name: assetImage?.originalWidth,
      ImageOfProductRowName.assetOriginalHeight.name:
          assetImage?.originalHeight,
    };
  }

  static ImageOfProduct fromMap(Map<String, dynamic> map) {
    return ImageOfProduct(
      id: map[ImageOfProductRowName.id.name],
      productId: map[ImageOfProductRowName.productId.name],
      memoryImage: map[ImageOfProductRowName.memoryImage.name],
      isAvatar:
          map[ImageOfProductRowName.isAvatar.name] as int == 0 ? false : true,
      assetImage: Asset(
        map[ImageOfProductRowName.assetIdentifier.name],
        map[ImageOfProductRowName.assetName.name],
        map[ImageOfProductRowName.assetOriginalWidth.name],
        map[ImageOfProductRowName.assetOriginalHeight.name],
      ),
    );
  }
}
