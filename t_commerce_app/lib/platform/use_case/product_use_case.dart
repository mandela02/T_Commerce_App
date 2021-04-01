import 'dart:typed_data';

import 'package:t_commerce_app/domain/model/category.dart';
import 'package:t_commerce_app/domain/model/category_of_product.dart';
import 'package:t_commerce_app/domain/model/image_of_product.dart';
import 'package:t_commerce_app/domain/model/product.dart';
import 'package:t_commerce_app/domain/use_case/product_use_case_type.dart';
import 'package:t_commerce_app/platform/database/configuration.dart';
import 'package:t_commerce_app/platform/repository/repository.dart';

class ProductUseCase implements ProductUseCaseType {
  Repository<Category> _categoryRepository = Repository();
  Repository<Product> _productRepository = Repository();
  Repository<CategoryOfProduct> _categoryOfProductRepository = Repository();
  Repository<ImageOfProduct> _imageOfProductRepository = Repository();

  @override
  Future<List<Category>> getAllCategory() async {
    List<Map<String, dynamic>> maps =
        await _categoryRepository.getAll(TableName.categoryTableName);
    return maps.map((e) => Category.fromMap(e)).toList();
  }

  @override
  Future<void> save(
      {required Product product,
      required Category category,
      required List<Uint8List> images,
      required Uint8List avatar}) async {
    await _productRepository.insert(product, TableName.productTableName);

    CategoryOfProduct categoryOfProduct = CategoryOfProduct.create(
        categoryId: category.id, productId: product.id);

    await _categoryOfProductRepository.insert(
        categoryOfProduct, TableName.categoryOfProductTableName);
    await _saveImage(product, images, avatar);
  }

  @override
  Future<void> update(
      {required Product product,
      required Category category,
      required List<Uint8List> images,
      required Uint8List avatar}) async {
    await _productRepository.update(
        product, "id", product.id, TableName.productTableName);

    await _updateCategory(product, category);
    await _updateImage(product, images, avatar);
  }

  @override
  Future<List<ImageOfProduct>> getAllImage({required Product product}) async {
    final id = product.id;
    final imageMaps = await _imageOfProductRepository.query(
        "productId", id, TableName.imageOfProductTableName);
    return imageMaps.map((e) => ImageOfProduct.fromMap(e)).toList();
  }
}

extension ProductUseCaseExtension on ProductUseCase {
  Future<void> _updateImage(
      Product product, List<Uint8List> images, Uint8List avatar) async {
    final existingImage = await getAllImage(product: product);
    final deleteQueue = existingImage.map((e) => _imageOfProductRepository
        .delete("id", e.id, TableName.imageOfProductTableName));
    Future.wait(deleteQueue);
    await _saveImage(product, images, avatar);
  }

  Future<void> _saveImage(
      Product product, List<Uint8List> images, Uint8List avatar) async {
    final list = images
        .map((data) => ImageOfProduct.create(
            productId: product.id, image: data, isAvatar: data == avatar))
        .toList()
        .map((e) => _imageOfProductRepository.insert(
            e, TableName.imageOfProductTableName))
        .toList();
    Future.wait(list);
  }

  Future<void> _updateCategory(Product product, Category category) async {
    List<Map<String, dynamic>> categoryOfProductMaps =
        await _categoryOfProductRepository.query(
            "productId", product.id, TableName.categoryOfProductTableName);

    List<CategoryOfProduct> categoryOfProducts =
        categoryOfProductMaps.map((e) => CategoryOfProduct.fromMap(e)).toList();

    List<Map<String, dynamic>> all = await _categoryOfProductRepository
        .getAll(TableName.categoryOfProductTableName);

    if (categoryOfProducts.isNotEmpty) {
      String categoryOfProductId = categoryOfProducts.first.id;
      CategoryOfProduct categoryOfProduct = CategoryOfProduct(
          categoryOfProductId,
          categoryId: category.id,
          productId: product.id);

      await _categoryOfProductRepository.update(categoryOfProduct, "id",
          categoryOfProductId, TableName.categoryOfProductTableName);
    }
  }
}
