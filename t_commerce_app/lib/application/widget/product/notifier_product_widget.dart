import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t_commerce_app/application/widget/product/product_view_model.dart';
import 'package:t_commerce_app/application/widget/product/product_widget.dart';

class NotifierProductWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductViewModel(),
      child: ProductWidget(),
    );
  }
}
