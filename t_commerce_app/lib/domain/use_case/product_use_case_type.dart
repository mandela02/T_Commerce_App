import 'package:t_commerce_app/domain/model/category.dart';

abstract class ProductUseCaseType {
  Future<List<Category>> getAllCategory();
}
