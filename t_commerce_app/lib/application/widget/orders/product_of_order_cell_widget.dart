import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t_commerce_app/application/widget/reusable_wigdet/increment_stepper_widget.dart';
import 'package:t_commerce_app/application/widget/reusable_wigdet/padding_card_widget.dart';
import 'package:t_commerce_app/application/widget/reusable_wigdet/round_corner_widget.dart';

class ProductOfOrderCellWidget extends StatefulWidget {
  @override
  _ProductOfOrderCellWidgetState createState() =>
      _ProductOfOrderCellWidgetState();
}

class _ProductOfOrderCellWidgetState extends State<ProductOfOrderCellWidget> {
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return PaddingCardWidget(
      child: Row(
        children: [
          RoundCornerWidget(
            size: 70,
            background: Colors.grey[100],
            child: Icon(Icons.camera),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Product",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Sku: ",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
                SizedBox(height: 5),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Icon(Icons.delete),
                  onPressed: () => print(_value)),
              IncrementStepperWidget(
                value: _value,
                onIncrease: () {
                  setState(() {
                    _value--;
                  });
                },
                onDecrease: () {
                  setState(() {
                    _value++;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
