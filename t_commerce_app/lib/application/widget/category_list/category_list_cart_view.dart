import 'package:flutter/material.dart';
import 'package:t_commerce_app/application/app/app_router.dart';
import 'package:t_commerce_app/domain/model/category.dart';

class CategoryListCardView extends StatelessWidget {
  final Category category;

  const CategoryListCardView({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      shadowColor: Colors.black,
      color: Colors.white,
      child: ListTile(
        onTap: () => Navigator.pushNamed(
          context,
          AppRouter.CATEGORY,
          arguments: category,
        ),
        title: Text(category.name),
        subtitle: Text(category.description),
        leading: category.image == null
            ? Icon(
                Icons.category,
              )
            : CircleAvatar(
                backgroundColor: Colors.grey[100],
                backgroundImage: MemoryImage(category.image!),
              ),
        isThreeLine: true,
      ),
    );
  }
}