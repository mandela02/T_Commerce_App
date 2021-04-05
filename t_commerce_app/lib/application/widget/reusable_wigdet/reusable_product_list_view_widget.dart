import 'package:flutter/material.dart';
import 'package:t_commerce_app/application/widget/products_list/product_card_widget.dart';
import 'package:t_commerce_app/domain/model/product_and_category.dart';

class ReusableProductListViewWidget extends StatelessWidget {
  final List<ProductAndCategory> products;
  final Function(ProductAndCategory) onCellTap;

  const ReusableProductListViewWidget(
      {Key? key, required this.products, required this.onCellTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: true,
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCardWidget(
          category: product.category,
          product: product.product,
          image: product.avatar,
          onCellTap: () => onCellTap(product),
        );
      },
    );
  }
}
