import 'package:flutter/cupertino.dart';
import 'package:t_commerce_app/domain/model/category.dart';
import 'package:t_commerce_app/domain/use_case/category_use_case_type.dart';
import 'package:t_commerce_app/domain/use_case/use_case_provider.dart';

class CategoryViewModel extends ChangeNotifier {
  Category? _category;
  late CategoryUseCaseType _useCase;

  String _name = "";
  String _description = "";

  CategoryViewModel({Category? category}) {
    this._category = category;
    this._useCase = UseCaseProvider().getCategoryUseCase();
  }

  String get buttonTitle {
    return _category == null ? "Create" : "Update";
  }

  String get appBarTitle {
    return _category == null ? "New category" : _category!.name;
  }

  bool get isSaveButtonEnable {
    return _name.isNotEmpty;
  }

  bool get isDeleteButtonVisible {
    return _category != null;
  }

  void save(BuildContext context) async {
    if (_category == null) {
      Category category =
          Category.create(name: _name, description: _description);
      await _useCase.add(category);
      Navigator.pop(context);
    }
  }

  void delete(BuildContext context) async {
    if (_category != null) {
      await _useCase.remove(_category!);
      Navigator.pop(context);
    }
  }

  void setName({required String name}) {
    this._name = name;
    notifyListeners();
  }

  void setDescription({required String description}) {
    this._description = description;
  }
}
