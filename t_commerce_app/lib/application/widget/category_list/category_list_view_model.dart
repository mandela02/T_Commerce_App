import 'package:flutter/cupertino.dart';
import 'package:t_commerce_app/domain/model/category.dart';
import 'package:t_commerce_app/domain/use_case/category_list_use_case_type.dart';
import 'package:t_commerce_app/domain/use_case/use_case_provider.dart';

class CategoryListViewModel extends ChangeNotifier {
  List<Category> _categories = [];
  List<Category> get categories => _categories.reversed.toList();

  late CategoryListUseCaseType _useCase;

  CategoryListViewModel()
      : _useCase = UseCaseProvider().getCategoryListUseCase();

  void getData() async {
    List<Category> categories = await _useCase.getAllCategory();
    _categories = categories;
    notifyListeners();
  }

  void delete(Category category) async {
    await _useCase.delete(category);
  }
}
