import 'package:t_commerce_app/domain/model/category.dart';
import 'package:t_commerce_app/domain/model/category_of_product.dart';
import 'package:t_commerce_app/domain/model/product.dart';
import 'package:t_commerce_app/domain/use_case/products_list_use_case_type.dart';
import 'package:t_commerce_app/platform/database/configuration.dart';
import 'package:t_commerce_app/platform/repository/repository.dart';

class ProductsListUseCase implements ProductsListUseCaseType {
  Repository<Product> _productRepository = Repository();
  Repository<Category> _categoryRepository = Repository();
  Repository<CategoryOfProduct> _categoryOfProductRepository = Repository();

  @override
  Future<List<Product>> getAllProduct() async {
    List<Map<String, dynamic>> maps =
        await _productRepository.getAll(TableName.PRODUCT_TABLE_NAME);
    return maps.map((e) => Product.fromMap(e)).toList();
  }

  @override
  Future<Category?> getSelectedCategory({required Product product}) async {
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
}
