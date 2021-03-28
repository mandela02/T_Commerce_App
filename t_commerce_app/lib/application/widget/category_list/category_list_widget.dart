import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t_commerce_app/application/widget/category_list/category_list_view_model.dart';
import 'package:t_commerce_app/domain/model/category.dart';

class CategoryListWidget extends StatefulWidget {
  @override
  _CategoryListWidgetState createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CategoryListViewModel>();
    viewModel.getData();
    final categories = viewModel.categories;

    return Scrollbar(
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          Category category = categories[index];
          return ListTile(
            onTap: () {},
            title: Text(category.name),
          );
        },
      ),
    );
  }
}
