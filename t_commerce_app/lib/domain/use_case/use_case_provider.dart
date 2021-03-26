import 'package:t_commerce_app/domain/use_case/category_use_case_type.dart';
import 'package:t_commerce_app/platform/use_case/category_use_case.dart';

class UseCaseProvider {
  static final UseCaseProvider _singleton = UseCaseProvider._internal();

  factory UseCaseProvider() {
    return _singleton;
  }

  UseCaseProvider._internal();

  CategoryUseCaseType getCategoryUseCase() {
    return CategoryUseCase();
  }
}
