import 'package:flutter/material.dart';
import 'package:t_commerce_app/domain/model/category.dart';
import 'package:t_commerce_app/domain/model/image_object.dart';
import 'package:t_commerce_app/domain/model/product.dart';

class ProductCardWidget extends StatelessWidget {
  final Category category;
  final Product product;
  final ImageObject image;
  final Function onCellTap;

  const ProductCardWidget(
      {Key? key,
      required this.category,
      required this.product,
      required this.image,
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
        leading: Container(
          height: 40,
          width: 40,
          child: Image(
            fit: BoxFit.cover,
            image: MemoryImage(image.memory),
          ),
        ),
        trailing: Column(
          children: [
            Text(
              "${product.originalPrice}\$",
              style: product.discountPrice == null
                  ? null
                  : TextStyle(decoration: TextDecoration.lineThrough),
            ),
            Text(product.discountPrice == null
                ? ""
                : "${product.discountPrice}\$"),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
