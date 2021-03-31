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

  ProductViewModel({required Product? product, required Category? category}) {
    this._product = product;
    this._selectedCategory = category;

    if (_product != null) {
      final notNullProduct = product!;
      setName(name: notNullProduct.name);
      setDescription(description: notNullProduct.description);
      setOriginalPrice(price: "${notNullProduct.originalPrice}");
      setDiscountPrice(price: "${notNullProduct.discountPrice}");
      setBarCode(barCode: notNullProduct.barCode);
    }
  }

  void getCategories() async {
    List<Category> categories = await _useCase.getAllCategory();
    _categories = categories;
    notifyListeners();
  }

  void change() {
    notifyListeners();
  }

  void saveProduct(BuildContext context) async {
    int now = DateTime.now().millisecondsSinceEpoch;
    int originalPrice = 0;
    int discountPrice = 0;

    try {
      originalPrice = int.parse(_originalPrice);
    } catch (e) {
      originalPrice = 999999;
    }

    try {
      discountPrice = int.parse(_discountPrice);
    } catch (e) {
      discountPrice = discountPrice;
    }

    if (_product == null) {
      final Product product = Product.create(
          name: _name,
          originalPrice: originalPrice,
          discountPrice: discountPrice,
          createDate: now,
          updateDate: now,
          barCode: _barCode,
          description: _description);
      if (_selectedCategory != null) {
        await _useCase.save(product: product, category: _selectedCategory!);
      }
    } else {
      Product existProduct = _product!;
      final Product product = Product(existProduct.id,
          name: _name,
          originalPrice: originalPrice,
          discountPrice: discountPrice,
          createDate: existProduct.createDate,
          updateDate: now,
          barCode: _barCode,
          description: _description);
      if (_selectedCategory != null) {
        await _useCase.update(product: product, category: _selectedCategory!);
      }
    }
    Navigator.pop(context);
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
    change();
  }

  void setDiscountPrice({required String price}) {
    _discountPrice = price;
    change();
  }

  void setOriginalPrice({required String price}) {
    _originalPrice = price;
    change();
  }

  void setDescription({required String description}) {
    _description = description;
    change();
  }

  void setName({required String name}) {
    _name = name;
    change();
  }
}
