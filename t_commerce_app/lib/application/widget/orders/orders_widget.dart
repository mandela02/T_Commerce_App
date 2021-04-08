import 'package:flutter/material.dart';
import 'package:t_commerce_app/application/widget/reusable_wigdet/padding_card_widget.dart';

class OrderWidget extends StatefulWidget {
  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [_productList],
            ),
          ),
        ],
      ),
    );
  }
}

extension OrderWidgetComputedPropertiesExtension on _OrderWidgetState {
  Widget get _productList {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            primary: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return ProductOfOrderCellWidget();
            },
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            child: Text(
              "Add a new product",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductOfOrderCellWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaddingCardWidget(
      child: Row(
        children: [
          RoundCornerWidget(
            size: 50,
            background: Colors.grey[100],
            child: Icon(Icons.camera),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Product",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Sku: ",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
                Text(
                  "Price: ",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          Text("SUMTHIN"),
        ],
      ),
    );
  }
}

class RoundCornerWidget extends StatelessWidget {
  final double size;
  final Color? background;
  final Widget child;

  RoundCornerWidget(
      {Key? key, required this.child, this.background, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      child: Container(
        height: size,
        color: background,
        child: AspectRatio(
          aspectRatio: 1,
          child: child,
        ),
      ),
    );
  }
}
