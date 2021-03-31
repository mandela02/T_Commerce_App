import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputTextFieldWidget extends StatelessWidget {
  final String title;
  final String placeholder;

  final double height;
  final bool isMultiLine;
  final double size;
  final TextEditingController? controller;
  final TextInputType keyboard;
  final Function(String) onTextChange;

  const InputTextFieldWidget(
      {Key? key,
      required this.title,
      required this.placeholder,
      required this.height,
      required this.isMultiLine,
      required this.size,
      required this.controller,
      required this.keyboard,
      required this.onTextChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: size,
          ),
        ),
        SizedBox(height: 8),
        ConstrainedBox(
          constraints: BoxConstraints(minHeight: height),
          child: CupertinoTextField(
            placeholder: placeholder,
            controller: controller,
            textAlignVertical:
                isMultiLine ? TextAlignVertical.top : TextAlignVertical.center,
            maxLines: isMultiLine ? null : 1,
            keyboardType: keyboard,
            style: TextStyle(
              fontSize: size,
            ),
            onChanged: (name) => onTextChange(name),
          ),
        ),
      ],
    );
  }
}
