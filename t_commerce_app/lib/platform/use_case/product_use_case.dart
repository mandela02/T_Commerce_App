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
  Future<void> update({required Product product}) {
    return _productRepository.update(
        product, "id", product.id, TableName.productTableName);
  }

  @override
  Future<void> save(
      {required Product product, required Category category}) async {
    // TODO: implement save
    await _productRepository.insert(product, TableName.productTableName);
    CategoryOfProduct categoryOfProduct = CategoryOfProduct.create(
        categoryId: category.id, productId: product.id);
    await _categoryOfProductRepository.insert(
        categoryOfProduct, TableName.categoryOfProductTableName);
  }
}
