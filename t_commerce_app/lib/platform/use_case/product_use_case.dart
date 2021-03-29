import 'package:t_commerce_app/domain/model/category.dart';
import 'package:t_commerce_app/domain/model/product.dart';
import 'package:t_commerce_app/domain/use_case/product_use_case_type.dart';
import 'package:t_commerce_app/platform/database/configuration.dart';
import 'package:t_commerce_app/platform/repository/repository.dart';

class ProductUseCase implements ProductUseCaseType {
  Repository<Category> _categoryRepository = Repository();
  Repository<Product> _productRepository = Repository();

  @override
  Future<List<Category>> getAllCategory() async {
    List<Map<String, dynamic>> maps =
        await _categoryRepository.getAll(TableName.categoryTableName);
    return maps.map((e) => Category.fromMap(e)).toList();
  }

  @override
  Future<void> save({required Product product}) {
    // TODO: implement save
    return _productRepository.insert(product, TableName.productTableName);
  }

  @override
  Future<void> update({required Product product}) {
    // TODO: implement update
    return _productRepository.update(
        product, "id", product.id, TableName.productTableName);
  }
}
