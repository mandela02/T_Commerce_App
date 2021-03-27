import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  late TextEditingController? _nameTextController;
  late TextEditingController? _descriptionTextController;

  double _commonFontSize = 12;

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
              fontSize: _commonFontSize,
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
              style: TextStyle(
                fontSize: _commonFontSize,
              ),
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
            fontSize: _commonFontSize,
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
              style: TextStyle(
                fontSize: _commonFontSize,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget get listOfProducts {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Products in this category: 0 product",
          style: TextStyle(
            fontSize: _commonFontSize,
          ),
          textAlign: TextAlign.start,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Category"),
        actions: [
          deleteButton,
        ],
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SafeArea(
          child: Container(
            color: Colors.white,
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Scrollbar(
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 8.0,
                        ),
                        headerField,
                        SizedBox(
                          height: 10,
                        ),
                        descriptionField,
                        SizedBox(
                          height: 10,
                        ),
                        listOfProducts,
                      ],
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 40),
                        child: Text(
                          "Save",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1000.0),
                          ),
                        ),
                        elevation: MaterialStateProperty.all<double>(0),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
