import 'package:t_commerce_app/domain/model/category.dart';
import 'package:t_commerce_app/domain/model/category_of_product.dart';
import 'package:t_commerce_app/domain/model/image_object.dart';
import 'package:t_commerce_app/domain/model/image_of_product.dart';
import 'package:t_commerce_app/domain/model/product.dart';
import 'package:t_commerce_app/domain/model/product_and_category.dart';
import 'package:t_commerce_app/domain/use_case/category_use_case_type.dart';
import 'package:t_commerce_app/platform/database/configuration.dart';
import 'package:t_commerce_app/platform/repository/repository.dart';

class CategoryUseCase implements CategoryUseCaseType {
  Repository<Category> _repository = Repository();
  Repository<CategoryOfProduct> _categoryOfProductRepository = Repository();
  Repository<Product> _productRepository = Repository();
  Repository<ImageOfProduct> _imageOfProductRepository = Repository();

  @override
  Future<void> add(Category category) {
    return _repository.insert(category, TableName.CATEGORY_TABLE_NAME);
  }

  @override
  Future<void> remove(Category category) {
    return _repository.delete(
        CategoryRowName.id.name, category.id, TableName.CATEGORY_TABLE_NAME);
  }

  @override
  Future<void> update(Category category) {
    return _repository.update(category, CategoryRowName.id.name, category.id,
        TableName.CATEGORY_TABLE_NAME);
  }

  @override
  Future<List<ProductAndCategory>> getAllProduct(
      {required Category category}) async {
    final categoryOfProductsMap = await _categoryOfProductRepository.query(
        CategoryOfProductRowName.categoryId.name,
        category.id,
        TableName.CATEGORY_OF_PRODUCT_TABLE_NAME);
    final categoryOfProducts =
        categoryOfProductsMap.map((e) => CategoryOfProduct.fromMap(e)).toList();
    final products = categoryOfProducts.map((e) async {
      final products = await _productRepository.query(
          ProductRowName.id.name, e.productId, TableName.PRODUCT_TABLE_NAME);
      if (products.isNotEmpty) {
        final product = Product.fromMap(products.first);
        final imageMap = await _imageOfProductRepository.query(
            ImageOfProductRowName.productId.name,
            product.id,
            TableName.IMAGE_OF_PRODUCT_TABLE_NAME);
        final avatars = imageMap
            .map((e) => ImageOfProduct.fromMap(e))
            .where((element) => element.isAvatar)
            .toList();
        if (avatars.isNotEmpty) {
          return ProductAndCategory(
              product: product,
              category: category,
              avatar: ImageObject(
                  memory: avatars.first.memoryImage,
                  asset: avatars.first.assetImage));
        } else {
          return null;
        }
      } else {
        return null;
      }
    });

    final finalProduct = await Future.wait(products);
    return finalProduct
        .where((element) => element != null)
        .map((e) => e!)
        .toList();
  }
}
