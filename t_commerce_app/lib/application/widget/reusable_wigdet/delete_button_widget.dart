import 'package:flutter/material.dart';

class DeleteButtonWidget extends StatelessWidget {
  final VoidCallback onClick;

  const DeleteButtonWidget({Key? key, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: onClick,
    );
  }
}
