import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AlertResult { success, cancel }

extension AlertResultExtension on AlertResult {
  String get result {
    switch (this) {
      case AlertResult.success:
        return "SUCCESS";
      case AlertResult.cancel:
        return "CANCEL";
    }
  }
}

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String successButtonTitle;
  final String cancelButtonTitle;

  const CustomAlertDialog(
      {Key? key,
      required this.title,
      required this.content,
      required this.successButtonTitle,
      required this.cancelButtonTitle})
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
            onPressed: () => Navigator.pop(context, AlertResult.success),
            child: Text(
              successButtonTitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, AlertResult.cancel),
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
