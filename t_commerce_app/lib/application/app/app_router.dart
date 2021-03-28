import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t_commerce_app/application/widget/category/notifier_category_widget.dart';

class AppRouter {
  static const String CATEGORY = "/category";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CATEGORY:
        return MaterialPageRoute(builder: (_) => NotifierCategoryWidget());
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
