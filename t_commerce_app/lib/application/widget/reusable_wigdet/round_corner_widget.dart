import 'package:flutter/material.dart';

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
