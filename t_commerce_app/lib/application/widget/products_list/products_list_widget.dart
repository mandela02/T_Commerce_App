import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t_commerce_app/application/app/app_router.dart';
import 'package:t_commerce_app/application/widget/products_list/products_list_view_model.dart';
import 'package:t_commerce_app/application/widget/reusable_wigdet/reusable_product_list_view_widget.dart';

class ProductsListWidget extends StatefulWidget {
  @override
  _ProductsListWidgetState createState() => _ProductsListWidgetState();
}

class _ProductsListWidgetState extends State<ProductsListWidget> {
  @override
  void initState() {
    super.initState();
    final viewModel = context.read<ProductsListViewModel>();
    viewModel.getData();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProductsListViewModel>();
    final products = viewModel.products;

    return Scrollbar(
      child: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            Expanded(
              child: ReusableProductListViewWidget(
                products: products,
                onCellTap: (product) async {
                  await Navigator.pushNamed(
                    context,
                    AppRouter.PRODUCT,
                    arguments: product,
                  );
                  viewModel.getData();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
