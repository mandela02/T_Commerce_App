import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t_commerce_app/application/app/app_router.dart';
import 'package:t_commerce_app/application/widget/products_list/products_list_view_model.dart';
import 'package:t_commerce_app/application/widget/reusable_wigdet/reusable_product_list_view_widget.dart';
import 'package:t_commerce_app/domain/model/category.dart';
import 'package:t_commerce_app/domain/model/product.dart';

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
    );
  }
}

class ProductCardWidget extends StatelessWidget {
  final Category category;
  final Product product;
  final Function onCellTap;

  const ProductCardWidget(
      {Key? key,
      required this.category,
      required this.product,
      required this.onCellTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.all(8),
      shadowColor: Colors.black,
      color: Colors.white,
      child: ListTile(
        onTap: () => onCellTap(),
        title: Text(product.name),
        subtitle: Text(category.categoryName),
        isThreeLine: true,
      ),
    );
  }
}
