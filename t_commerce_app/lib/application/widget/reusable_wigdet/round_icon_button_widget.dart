import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundIconButtonWidget extends StatelessWidget {
  final Color? backgroundColor;
  final Color? tintColor;
  final double? width;
  final double? height;
  final Radius? cornerRadius;
  final IconData icon;
  final Function onButtonTap;

  const RoundIconButtonWidget(
      {Key? key,
      this.backgroundColor,
      this.tintColor,
      this.width,
      this.height,
      this.cornerRadius,
      required this.icon,
      required this.onButtonTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius:
            cornerRadius == null ? null : BorderRadius.all(cornerRadius!),
      ),
      height: height,
      width: width,
      child: CupertinoButton(
        child: Icon(
          icon,
          color: tintColor,
        ),
        onPressed: () => onButtonTap(),
      ),
    );
  }
}
