import 'package:flutter/material.dart';
import 'package:t_commerce_app/domain/model/category.dart';
import 'package:t_commerce_app/domain/model/product.dart';
import 'package:t_commerce_app/domain/use_case/products_list_use_case_type.dart';
import 'package:t_commerce_app/domain/use_case/use_case_provider.dart';

class ProductsListViewModel extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products.reversed.toList();

  late ProductsListUseCaseType _useCase;

  ProductsListViewModel()
      : _useCase = UseCaseProvider().getProductsListUseCase();

  void getData() async {
    List<Product> products = await _useCase.getAllProduct();
    _products = products;
    notifyListeners();
  }

  Future<Category?> getCategory({required Product product}) async {
    return _useCase.getSelectedCategory(product: product);
  }
}
