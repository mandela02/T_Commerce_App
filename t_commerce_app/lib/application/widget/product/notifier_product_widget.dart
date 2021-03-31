import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t_commerce_app/application/widget/product/product_view_model.dart';
import 'package:t_commerce_app/application/widget/product/product_widget.dart';
import 'package:t_commerce_app/domain/model/category.dart';
import 'package:t_commerce_app/domain/model/product.dart';

class NotifierProductWidget extends StatelessWidget {
  final Product? product;
  final Category? category;

  const NotifierProductWidget(
      {Key? key, required this.product, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductViewModel(product: product, category: category),
      child: ProductWidget(),
    );
  }
}
