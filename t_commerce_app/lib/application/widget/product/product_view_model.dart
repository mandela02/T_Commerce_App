import 'package:flutter/cupertino.dart';
import 'package:t_commerce_app/domain/model/category.dart';
import 'package:t_commerce_app/domain/model/product.dart';
import 'package:t_commerce_app/domain/use_case/product_use_case_type.dart';
import 'package:t_commerce_app/domain/use_case/use_case_provider.dart';

class ProductViewModel extends ChangeNotifier {
  ProductUseCaseType _useCase = UseCaseProvider().getProductUseCase();

  List<Category> _categories = [];

  Category? _selectedCategory;
  Product? _product;

  String _name = "";
  String _description = "";
  String _originalPrice = "";
  String _discountPrice = "";
  String _barCode = "";

  void getCategories() async {
    List<Category> categories = await _useCase.getAllCategory();
    _categories = categories;
    notifyListeners();
  }

  void change() {
    notifyListeners();
  }
}

extension ProductViewModelGetter on ProductViewModel {
  String get name {
    return _name;
  }

  String get description {
    return _description;
  }

  String get originalPrice {
    return _originalPrice;
  }

  String get discountPrice {
    return _discountPrice;
  }

  String get barCode {
    return _barCode;
  }

  String get appBarTitle {
    return _product == null ? "New product" : _product!.name;
  }

  String get buttonTitle {
    return _product == null ? "Create" : "Update";
  }

  bool get isSaveButtonEnable {
    return _name.isNotEmpty &&
        _selectedCategory != null &&
        _originalPrice.isNotEmpty;
  }

  bool get isDeleteButtonVisible {
    return _product != null;
  }

  List<Category> get categories {
    return _categories;
  }

  Category? get selectedCategory {
    return _selectedCategory;
  }
}

extension ProductViewModelSetter on ProductViewModel {
  void setSelectedCategory({required Category? category}) {
    this._selectedCategory = category;
    change();
  }

  void setBarCode({required String barCode}) {
    _barCode = barCode;
  }

  void setDiscountPrice({required String price}) {
    _discountPrice = price;
  }

  void setOriginalPrice({required String price}) {
    _originalPrice = price;
    change();
  }

  void setDescription({required String description}) {
    _description = description;
  }

  void setName({required String name}) {
    _name = name;
    change();
  }
}
