import 'package:t_commerce_app/domain/model/category.dart';
import 'package:t_commerce_app/domain/model/category_of_product.dart';
import 'package:t_commerce_app/domain/model/image_object.dart';
import 'package:t_commerce_app/domain/model/image_of_product.dart';
import 'package:t_commerce_app/domain/model/product.dart';
import 'package:t_commerce_app/domain/model/product_and_category.dart';
import 'package:t_commerce_app/domain/use_case/products_list_use_case_type.dart';
import 'package:t_commerce_app/platform/database/configuration.dart';
import 'package:t_commerce_app/platform/repository/repository.dart';

class ProductsListUseCase implements ProductsListUseCaseType {
  Repository<Product> _productRepository = Repository();
  Repository<CategoryOfProduct> _categoryOfProductRepository = Repository();
  Repository<ImageOfProduct> _imageOfProductRepository = Repository();

  @override
  Future<List<ProductAndCategory>> getAllProduct() async {
    List<Map<String, dynamic>> maps =
        await _productRepository.getAll(TableName.PRODUCT_TABLE_NAME);
    final products = maps.map((e) => Product.fromMap(e)).toList();
    final productOfCategories = products.map((product) async {
      final category = await _getSelectedCategory(product: product);
      if (category == null) {
        return null;
      } else {
        final avatar = await _getAvatar(product: product);
        if (avatar == null) {
          return null;
        } else {
          return ProductAndCategory(
              product: product, category: category, avatar: avatar);
        }
      }
    });

    final result = await Future.wait(productOfCategories);
    return result.where((element) => element != null).map((e) => e!).toList();
  }

  Future<Category?> _getSelectedCategory({required Product product}) async {
    List<Map<String, dynamic>> categoryOfProductMaps =
        await _categoryOfProductRepository.query(
            CategoryOfProductRowName.productId.name,
            product.id,
            TableName.CATEGORY_OF_PRODUCT_TABLE_NAME);

    List<CategoryOfProduct> categoryOfProducts =
        categoryOfProductMaps.map((e) => CategoryOfProduct.fromMap(e)).toList();

    if (categoryOfProducts.isNotEmpty) {
      String categoryId = categoryOfProducts.first.categoryId;
      List<Map<String, dynamic>> categoriesMaps =
          await _categoryOfProductRepository.query(
              CategoryOfProductRowName.id.name,
              categoryId,
              TableName.CATEGORY_TABLE_NAME);

      List<Category> categories =
          categoriesMaps.map((e) => Category.fromMap(e)).toList();

      if (categories.isNotEmpty) {
        return categories.first;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<ImageObject?> _getAvatar({required Product product}) async {
    final imagesMap = await _imageOfProductRepository.query(
        ImageOfProductRowName.productId.name,
        product.id,
        TableName.IMAGE_OF_PRODUCT_TABLE_NAME);
    final images = imagesMap
        .map((e) => ImageOfProduct.fromMap(e))
        .where((element) => element.isAvatar);
    if (images.isEmpty) {
      return null;
    } else {
      return ImageObject(
          memory: images.first.memoryImage, asset: images.first.assetImage);
    }
  }
}
