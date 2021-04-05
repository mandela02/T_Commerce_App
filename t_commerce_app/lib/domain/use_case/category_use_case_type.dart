import 'package:t_commerce_app/domain/model/category.dart';
import 'package:t_commerce_app/domain/model/product_and_category.dart';

abstract class CategoryUseCaseType {
  Future<void> add(Category category);
  Future<void> update(Category category);
  Future<void> remove(Category category);
  Future<List<ProductAndCategory>> getAllProduct({required Category category});
}
