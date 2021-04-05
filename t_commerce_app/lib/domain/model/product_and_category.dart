import 'package:t_commerce_app/domain/model/category.dart';
import 'package:t_commerce_app/domain/model/image_object.dart';
import 'package:t_commerce_app/domain/model/product.dart';

class ProductAndCategory {
  final Product product;
  final Category category;
  final ImageObject avatar;

  ProductAndCategory({
    required this.product,
    required this.category,
    required this.avatar,
  });
}
