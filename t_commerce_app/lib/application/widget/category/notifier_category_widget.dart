import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t_commerce_app/application/widget/category/category_view_model.dart';
import 'package:t_commerce_app/application/widget/category/category_widget.dart';

class NotifierCategoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CategoryViewModel(),
      child: CategoryWidget(),
    );
  }
}
