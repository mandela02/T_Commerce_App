import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t_commerce_app/application/widget/orders/product_of_order_cell_widget.dart';
import 'package:t_commerce_app/application/widget/reusable_wigdet/intput_text_field_widget.dart';
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
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      color: Colors.grey[200],
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _productList,
                SizedBox(
                  height: 20,
                ),
                _totalPrice,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension OrderWidgetComputedPropertiesExtension on _OrderWidgetState {
  Widget get _productList {
    return Column(
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
                fontWeight: FontWeight.bold, fontSize: 25, color: Colors.blue),
          ),
        ),
      ],
    );
  }

  Widget get _totalPrice {
    return PaddingCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          labelWithTitle(title: "Total products", content: "50"),
          SizedBox(height: 20),
          labelWithTitle(title: "Total Cost", content: "500"),
        ],
      ),
    );
  }
}

extension OrderWidgetFunctionExtension on _OrderWidgetState {
  Widget labelWithTitle({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        SizedBox(height: 10),
        Text(
          content,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget textViewWithTitle() {
    return InputTextFieldWidget(
        title: "Discount",
        height: 40,
        isMultiLine: false,
        size: 20,
        onTextChange: (text) {});
  }
}
