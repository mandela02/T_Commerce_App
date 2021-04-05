import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:t_commerce_app/domain/model/category.dart';
import 'package:t_commerce_app/domain/model/product_and_category.dart';
import 'package:t_commerce_app/domain/use_case/category_use_case_type.dart';
import 'package:t_commerce_app/domain/use_case/use_case_provider.dart';

class CategoryViewModel extends ChangeNotifier {
  Category? _category;
  late CategoryUseCaseType _useCase;

  String _name = "";
  String _description = "";
  Uint8List? _image;

  List<ProductAndCategory> _products = [];

  CategoryViewModel({Category? category}) {
    this._category = category;
    this._useCase = UseCaseProvider().getCategoryUseCase();
    setName(name: _category?.categoryName ?? "");
    setDescription(description: _category?.description ?? "");
    setFile(image: _category?.memoryImage);
    getProducts();
  }

  Future<void> getProducts() async {
    if (_category != null) {
      final products = await _useCase.getAllProduct(category: _category!);
      _products = products;
      notifyListeners();
    }
  }

  List<ProductAndCategory> get products => _products;

  Uint8List? get image => _image;

  Category? get category => _category;

  String get buttonTitle => _category == null ? "Create" : "Update";

  String get appBarTitle =>
      _category == null ? "New category" : _category!.categoryName;

  bool get isSaveButtonEnable => _name.isNotEmpty;

  bool get isDeleteButtonVisible => _category != null;

  void save(BuildContext context) async {
    if (_category == null) {
      Category category = Category.create(
          categoryName: _name, description: _description, memoryImage: image);
      await _useCase.add(category);
    } else {
      Category existCategory = _category!;
      Category category = Category(
          id: existCategory.id,
          categoryName: _name,
          description: _description,
          memoryImage: image);
      await _useCase.update(category);
    }
    Navigator.pop(context);
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

  void setFile({required Uint8List? image}) {
    this._image = image;
    notifyListeners();
  }
}
