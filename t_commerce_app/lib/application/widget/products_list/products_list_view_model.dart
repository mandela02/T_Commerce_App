import 'package:flutter/material.dart';
import 'package:t_commerce_app/domain/model/product_and_category.dart';
import 'package:t_commerce_app/domain/use_case/products_list_use_case_type.dart';
import 'package:t_commerce_app/domain/use_case/use_case_provider.dart';

class ProductsListViewModel extends ChangeNotifier {
  List<ProductAndCategory> _products = [];
  List<ProductAndCategory> get products => _products.reversed.toList();

  late ProductsListUseCaseType _useCase;

  ProductsListViewModel()
      : _useCase = UseCaseProvider().getProductsListUseCase();

  void getData() async {
    await getListProduct();
    notifyListeners();
  }

  Future<void> getListProduct() async {
    final products = await _useCase.getAllProduct();
    _products = products;
  }
}
