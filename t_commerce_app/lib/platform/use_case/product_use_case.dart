import 'package:t_commerce_app/domain/model/category.dart';
import 'package:t_commerce_app/domain/model/category_of_product.dart';
import 'package:t_commerce_app/domain/model/image_object.dart';
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
        await _categoryRepository.getAll(TableName.CATEGORY_TABLE_NAME);
    return maps.map((e) => Category.fromMap(e)).toList();
  }

  @override
  Future<void> save(
      {required Product product,
      required Category category,
      required List<ImageObject> images,
      required ImageObject avatar}) async {
    await _productRepository.insert(product, TableName.PRODUCT_TABLE_NAME);

    CategoryOfProduct categoryOfProduct = CategoryOfProduct.create(
        categoryId: category.id, productId: product.id);

    await _categoryOfProductRepository.insert(
        categoryOfProduct, TableName.CATEGORY_OF_PRODUCT_TABLE_NAME);
    await _saveImage(product, images, avatar);
  }

  @override
  Future<void> update(
      {required Product product,
      required Category category,
      required List<ImageObject> images,
      required ImageObject avatar}) async {
    await _productRepository.update(product, CategoryRowName.id.name,
        product.id, TableName.PRODUCT_TABLE_NAME);

    await _updateCategory(product, category);
    await _updateImage(product, images, avatar);
  }

  @override
  Future<List<ImageOfProduct>> getAllImage({required Product product}) async {
    final id = product.id;
    final imageMaps = await _imageOfProductRepository.query(
        ImageOfProductRowName.productId.name,
        id,
        TableName.IMAGE_OF_PRODUCT_TABLE_NAME);
    return imageMaps.map((e) => ImageOfProduct.fromMap(e)).toList();
  }

  @override
  Future<void> delete({required Product product}) {
    return _productRepository.delete(
        ProductRowName.id.name, product.id, TableName.PRODUCT_TABLE_NAME);
  }
}

extension ProductUseCaseExtension on ProductUseCase {
  Future<void> _updateImage(
      Product product, List<ImageObject> images, ImageObject avatar) async {
    final existingImage = await getAllImage(product: product);
    final deleteQueue = existingImage.map((e) =>
        _imageOfProductRepository.delete(ImageOfProductRowName.id.name, e.id,
            TableName.IMAGE_OF_PRODUCT_TABLE_NAME));
    Future.wait(deleteQueue);
    await _saveImage(product, images, avatar);
  }

  Future<void> _saveImage(
      Product product, List<ImageObject> images, ImageObject avatar) async {
    final list = images
        .map((e) => ImageOfProduct.create(
            productId: product.id,
            memoryImage: e.memory,
            isAvatar: e == avatar,
            assetImage: e.asset))
        .map((e) => _imageOfProductRepository.insert(
            e, TableName.IMAGE_OF_PRODUCT_TABLE_NAME))
        .toList();
    Future.wait(list);
  }

  Future<void> _updateCategory(Product product, Category category) async {
    List<Map<String, dynamic>> categoryOfProductMaps =
        await _categoryOfProductRepository.query(
            CategoryOfProductRowName.productId.name,
            product.id,
            TableName.CATEGORY_OF_PRODUCT_TABLE_NAME);

    List<CategoryOfProduct> categoryOfProducts =
        categoryOfProductMaps.map((e) => CategoryOfProduct.fromMap(e)).toList();
    if (categoryOfProducts.isNotEmpty) {
      String categoryOfProductId = categoryOfProducts.first.id;
      CategoryOfProduct categoryOfProduct = CategoryOfProduct(
          categoryOfProductId,
          categoryId: category.id,
          productId: product.id);

      await _categoryOfProductRepository.update(
          categoryOfProduct,
          CategoryOfProductRowName.id.name,
          categoryOfProductId,
          TableName.CATEGORY_OF_PRODUCT_TABLE_NAME);
    }
  }
}
