import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  late TextEditingController? _nameTextController;
  late TextEditingController? _descriptionTextController;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  void _initController() {
    _nameTextController = TextEditingController(text: "");
    _descriptionTextController = TextEditingController(text: "");
  }

  Widget get deleteButton {
    return IconButton(icon: Icon(Icons.delete), onPressed: () {});
  }

  Widget get headerField {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.red,
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: nameField,
        ),
      ],
    );
  }

  Widget get nameField {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Name *",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 40,
            child: CupertinoTextField(
              placeholder: "Enter product name",
              controller: _nameTextController,
              textAlignVertical: TextAlignVertical.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget get descriptionField {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Description",
          style: TextStyle(
            fontSize: 20,
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(
          height: 10,
        ),
        Scrollbar(
          child: Container(
            height: 200,
            child: CupertinoTextField(
              controller: _descriptionTextController,
              placeholder: "Enter description",
              maxLines: null,
              textAlignVertical: TextAlignVertical.top,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("category"),
        actions: [deleteButton],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          color: Colors.white,
          height: double.infinity,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              headerField,
              SizedBox(
                height: 10,
              ),
              descriptionField,
            ],
          ),
        ),
      ),
    );
  }
}
