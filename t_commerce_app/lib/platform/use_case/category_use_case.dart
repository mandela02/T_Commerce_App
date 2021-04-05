import 'package:t_commerce_app/domain/model/category.dart';
import 'package:t_commerce_app/domain/use_case/category_use_case_type.dart';
import 'package:t_commerce_app/platform/database/configuration.dart';
import 'package:t_commerce_app/platform/repository/repository.dart';

class CategoryUseCase implements CategoryUseCaseType {
  Repository<Category> _repository = Repository();

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
    // TODO: implement update
    return _repository.update(category, CategoryRowName.id.name, category.id,
        TableName.CATEGORY_TABLE_NAME);
  }
}
