import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t_commerce_app/application/widget/category_list/category_list_view_model.dart';
import 'package:t_commerce_app/application/widget/category_list/category_list_widget.dart';

class NotifierCategoryListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CategoryListViewModel(),
      child: CategoryListWidget(),
    );
  }
}
