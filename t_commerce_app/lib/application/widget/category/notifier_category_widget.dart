import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t_commerce_app/application/widget/category/category_view_model.dart';
import 'package:t_commerce_app/application/widget/category/category_widget.dart';
import 'package:t_commerce_app/domain/model/category.dart';

class NotifierCategoryWidget extends StatelessWidget {
  final Category? category;

  const NotifierCategoryWidget({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CategoryViewModel(category: category),
      child: CategoryWidget(),
    );
  }
}
