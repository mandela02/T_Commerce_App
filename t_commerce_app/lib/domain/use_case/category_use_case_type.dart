import 'package:t_commerce_app/domain/model/category.dart';

abstract class CategoryUseCaseType {
  Future<void> add(Category category);
  Future<void> remove(Category category);
}
