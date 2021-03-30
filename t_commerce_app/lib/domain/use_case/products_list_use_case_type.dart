import 'package:t_commerce_app/domain/model/category.dart';
import 'package:t_commerce_app/domain/model/product.dart';

abstract class ProductsListUseCaseType {
  Future<List<Product>> getAllProduct();
  Future<Category?> getSelectedCategory({required Product product});
}
