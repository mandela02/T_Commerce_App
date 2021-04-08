import 'package:flutter/material.dart';

class RoundButtonWidget extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Function? onClick;

  const RoundButtonWidget(
      {Key? key,
      required this.title,
      required this.backgroundColor,
      required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick == null ? null : () => onClick!(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(
          Colors.transparent,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1000.0),
          ),
        ),
        elevation: MaterialStateProperty.all<double>(0),
        backgroundColor: MaterialStateProperty.all<Color>(
          backgroundColor,
        ),
      ),
    );
  }
}
