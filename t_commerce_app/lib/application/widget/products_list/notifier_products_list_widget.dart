import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t_commerce_app/application/widget/products_list/products_list_view_model.dart';
import 'package:t_commerce_app/application/widget/products_list/products_list_widget.dart';

class NotifierProductsListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductsListViewModel(),
      child: ProductsListWidget(),
    );
  }
}
