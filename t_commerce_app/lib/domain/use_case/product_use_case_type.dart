import 'package:t_commerce_app/domain/model/category.dart';
import 'package:t_commerce_app/domain/model/product.dart';

abstract class ProductUseCaseType {
  Future<List<Category>> getAllCategory();
  Future<void> save({required Product product, required Category category});
  Future<void> update({required Product product, required Category category});
}
