import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t_commerce_app/application/widget/category/notifier_category_widget.dart';
import 'package:t_commerce_app/application/widget/product/notifier_product_widget.dart';
import 'package:t_commerce_app/domain/model/category.dart';
import 'package:t_commerce_app/domain/model/product_and_category.dart';

class AppRouter {
  static const String CATEGORY = "/category";
  static const String PRODUCT = "/product";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PRODUCT:
        final argument = settings.arguments as ProductAndCategory?;
        return MaterialPageRoute(
          builder: (_) => NotifierProductWidget(
            product: argument?.product,
            category: argument?.category,
          ),
        );
      case CATEGORY:
        final category = settings.arguments as Category?;
        return MaterialPageRoute(
          builder: (_) => NotifierCategoryWidget(
            category: category,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
