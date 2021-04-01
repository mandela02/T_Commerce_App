import 'dart:typed_data';

import 'package:t_commerce_app/domain/model/category.dart';
import 'package:t_commerce_app/domain/model/image_of_product.dart';
import 'package:t_commerce_app/domain/model/product.dart';

abstract class ProductUseCaseType {
  Future<List<Category>> getAllCategory();
  Future<void> save(
      {required Product product,
      required Category category,
      required List<Uint8List> images,
      required Uint8List avatar});
  Future<void> update(
      {required Product product,
      required Category category,
      required List<Uint8List> images,
      required Uint8List avatar});
  Future<List<ImageOfProduct>> getAllImage({required Product product});
}
