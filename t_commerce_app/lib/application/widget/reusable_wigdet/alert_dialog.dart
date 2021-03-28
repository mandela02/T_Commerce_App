import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String successButtonTitle;
  final String cancelButtonTitle;

  final Function onSuccess;
  final Function onCancel;

  const CustomAlertDialog(
      {Key? key,
      required this.title,
      required this.content,
      required this.successButtonTitle,
      required this.onSuccess,
      required this.cancelButtonTitle,
      required this.onCancel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withAlpha(5),
      child: CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              onSuccess();
              Navigator.pop(context);
            },
            child: Text(
              successButtonTitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              onCancel();
              Navigator.pop(context);
            },
            child: Text(
              cancelButtonTitle,
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
