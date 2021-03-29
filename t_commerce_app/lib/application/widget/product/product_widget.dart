import 'package:flutter/material.dart';
import 'package:t_commerce_app/application/widget/reusable_wigdet/delete_button_widget.dart';
import 'package:t_commerce_app/application/widget/reusable_wigdet/intput_text_field_widget.dart';
import 'package:t_commerce_app/application/widget/reusable_wigdet/round_button_widget.dart';

class ProductWidget extends StatefulWidget {
  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  double _commonFontSize = 12;

  Widget get _nameWidget {
    return InputTextFieldWidget(
        title: "Name*",
        placeholder: "Enter production name",
        height: 40,
        isMultiLine: false,
        size: _commonFontSize,
        controller: null,
        onTextChange: (name) {});
  }

  Widget get _descriptionWidget {
    return InputTextFieldWidget(
        title: "Description",
        placeholder: "Enter production description",
        height: 200,
        isMultiLine: true,
        size: _commonFontSize,
        controller: null,
        onTextChange: (name) {});
  }

  Widget get _priceWidget {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: InputTextFieldWidget(
              title: "Original Price",
              placeholder: "Enter price",
              height: 40,
              isMultiLine: false,
              size: _commonFontSize,
              controller: null,
              onTextChange: (name) {}),
        ),
        SizedBox(width: 20),
        Expanded(
          flex: 1,
          child: InputTextFieldWidget(
              title: "Discount Price",
              placeholder: "Enter price",
              height: 40,
              isMultiLine: false,
              size: _commonFontSize,
              controller: null,
              onTextChange: (name) {}),
        ),
      ],
    );
  }

  Widget get _barCodeWidget {
    return Row(
      children: [
        Expanded(
          child: InputTextFieldWidget(
              title: "Barcode",
              placeholder: "Enter this product's barcode",
              height: 40,
              isMultiLine: false,
              size: _commonFontSize,
              controller: null,
              onTextChange: (name) {}),
        ),
        Container(
          height: 65,
          child: TextButton(
            onPressed: () {},
            child: Icon(Icons.qr_code),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Product"),
        actions: [DeleteButtonWidget(onClick: () => {})],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Scrollbar(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      _nameWidget,
                      SizedBox(height: 20),
                      _priceWidget,
                      SizedBox(height: 20),
                      _barCodeWidget,
                      SizedBox(height: 20),
                      _descriptionWidget,
                    ],
                  ),
                ),
                Center(
                  child: RoundButtonWidget(
                      title: "title",
                      backgroundColor: Colors.red,
                      onClick: () {}),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
