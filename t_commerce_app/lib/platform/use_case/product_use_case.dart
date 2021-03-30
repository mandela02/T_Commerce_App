import 'package:t_commerce_app/domain/model/category.dart';
import 'package:t_commerce_app/domain/model/category_of_product.dart';
import 'package:t_commerce_app/domain/model/product.dart';
import 'package:t_commerce_app/domain/use_case/product_use_case_type.dart';
import 'package:t_commerce_app/platform/database/configuration.dart';
import 'package:t_commerce_app/platform/repository/repository.dart';

class ProductUseCase implements ProductUseCaseType {
  Repository<Category> _categoryRepository = Repository();
  Repository<Product> _productRepository = Repository();
  Repository<CategoryOfProduct> _categoryOfProductRepository = Repository();

  @override
  Future<List<Category>> getAllCategory() async {
    List<Map<String, dynamic>> maps =
        await _categoryRepository.getAll(TableName.categoryTableName);
    return maps.map((e) => Category.fromMap(e)).toList();
  }

  @override
  Future<void> update(
      {required Product product, required Category category}) async {
    await _productRepository.update(
        product, "id", product.id, TableName.productTableName);

    List<Map<String, dynamic>> categoryOfProductMaps =
        await _categoryOfProductRepository.query(
            "productId", product.id, TableName.categoryOfProductTableName);

    List<CategoryOfProduct> categoryOfProducts =
        categoryOfProductMaps.map((e) => CategoryOfProduct.fromMap(e)).toList();
    print(product.id);
    List<Map<String, dynamic>> all = await _categoryOfProductRepository
        .getAll(TableName.categoryOfProductTableName);
    print(categoryOfProducts);
    print(all);

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

  @override
  Future<void> save(
      {required Product product, required Category category}) async {
    await _productRepository.insert(product, TableName.productTableName);

    CategoryOfProduct categoryOfProduct = CategoryOfProduct.create(
        categoryId: category.id, productId: product.id);
    await _categoryOfProductRepository.insert(
        categoryOfProduct, TableName.categoryOfProductTableName);
  }
}
