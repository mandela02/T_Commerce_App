import 'package:flutter/material.dart';
import 'package:t_commerce_app/domain/model/category.dart';

class CategoryListCardWidget extends StatelessWidget {
  final Category category;
  final Function onTap;

  const CategoryListCardWidget(
      {Key? key, required this.category, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.all(8),
      shadowColor: Colors.black,
      color: Colors.white,
      child: ListTile(
        onTap: () => onTap(),
        title: Text(category.categoryName),
        subtitle: Text(
          category.description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        leading: category.memoryImage == null
            ? Icon(Icons.category)
            : CircleAvatar(
                backgroundColor: Colors.grey[100],
                backgroundImage: MemoryImage(category.memoryImage!),
              ),
        isThreeLine: true,
      ),
    );
  }
}
