import 'package:t_commerce_app/domain/model/product_and_category.dart';

abstract class ProductsListUseCaseType {
  Future<List<ProductAndCategory>> getAllProduct();
}
