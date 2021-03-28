import 'package:t_commerce_app/domain/model/category.dart';

abstract class CategoryListUseCaseType {
  Future<List<Category>> getAllCategory();
  Future<void> add(Category category);
  Future<void> delete(Category category);
}
