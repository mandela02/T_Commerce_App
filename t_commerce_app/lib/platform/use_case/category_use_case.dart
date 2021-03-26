import 'package:t_commerce_app/domain/model/category.dart';
import 'package:t_commerce_app/domain/use_case/category_use_case_type.dart';
import 'package:t_commerce_app/platform/database/configuration.dart';
import 'package:t_commerce_app/platform/repository/repository.dart';

class CategoryUseCase implements CategoryUseCaseType {
  Repository<Category> _repository = Repository();

  @override
  Future<List<Category>> getAllCategory() async {
    List<Map<String, dynamic>> maps =
        await _repository.getAll(TableName.categoryTableName);
    return maps.map((e) => Category.fromMap(e)).toList();
  }

  @override
  Future<void> add(Category category) {
    return _repository.insert(category, TableName.categoryTableName);
  }

  @override
  Future<void> delete(Category category) async {
    // TODO: implement delete
    return _repository.delete("id", category.id, TableName.categoryTableName);
  }
}
