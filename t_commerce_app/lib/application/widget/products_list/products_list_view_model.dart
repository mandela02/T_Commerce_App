import 'package:flutter/material.dart';
import 'package:t_commerce_app/domain/model/category.dart';
import 'package:t_commerce_app/domain/model/product.dart';
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

  Future<Category?> getCategory({required Product product}) async {
    return _useCase.getSelectedCategory(product: product);
  }

  Future<void> getListProduct() async {
    List<Product> products = await _useCase.getAllProduct();
    final data = products.map((product) async {
      final category = await getCategory(product: product);
      if (category != null) {
        return ProductAndCategory(product: product, category: category);
      }
      return null;
    });
    final finalData = await Future.wait(data);
    _products =
        finalData.where((element) => element != null).map((e) => e!).toList();
  }
}
