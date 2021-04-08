import 'package:flutter/material.dart';

class PaddingCardWidget extends StatelessWidget {
  final Widget child;

  const PaddingCardWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: child,
      ),
    );
  }
}
