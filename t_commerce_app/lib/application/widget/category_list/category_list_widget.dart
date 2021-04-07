import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t_commerce_app/application/app/app_router.dart';
import 'package:t_commerce_app/application/widget/category_list/category_list_card_widget.dart';
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
    final viewModel = context.read<CategoryListViewModel>();
    viewModel.getData();
  }

  Widget get gridView {
    final viewModel = context.watch<CategoryListViewModel>();
    final categories = viewModel.categories;

    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 8;
    final double itemWidth = size.width / 2;

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: (itemWidth / itemHeight),
      children: categories
          .map(
            (e) => CategoryListCardWidget(
              category: e,
              onTap: () async {
                await Navigator.pushNamed(
                  context,
                  AppRouter.CATEGORY,
                  arguments: e,
                );
                viewModel.getData();
              },
            ),
          )
          .toList(),
    );
  }

  Widget get listView {
    final viewModel = context.watch<CategoryListViewModel>();
    final categories = viewModel.categories;

    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        Category category = categories[index];
        return CategoryListCardWidget(
          category: category,
          onTap: () async {
            await Navigator.pushNamed(
              context,
              AppRouter.CATEGORY,
              arguments: category,
            );

            viewModel.getData();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Container(
        color: Colors.grey[100],
        child: gridView,
      ),
    );
  }
}
