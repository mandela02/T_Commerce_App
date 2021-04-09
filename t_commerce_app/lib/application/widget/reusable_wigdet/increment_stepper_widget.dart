import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IncrementStepperWidget extends StatelessWidget {
  final int value;
  final Function onIncrease;
  final Function onDecrease;

  const IncrementStepperWidget(
      {Key? key,
      required this.value,
      required this.onIncrease,
      required this.onDecrease})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: value == 1 ? null : () => onIncrease(),
          child: Icon(Icons.remove),
        ),
        Container(
          width: 50,
          height: 25,
          child: Center(child: Text("$value")),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            border: Border.all(width: 1, color: Colors.grey),
          ),
        ),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => onDecrease(),
          child: Icon(Icons.add),
        ),
      ],
    );
  }
}
