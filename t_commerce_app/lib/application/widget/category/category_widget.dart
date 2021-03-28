import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:t_commerce_app/application/widget/category/action_sheet_result.dart';
import 'package:t_commerce_app/application/widget/category/category_view_model.dart';
import 'package:t_commerce_app/application/widget/reusable_wigdet/alert_dialog.dart';

class CategoryWidget extends StatefulWidget {
  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  final picker = ImagePicker();

  late TextEditingController? _nameTextController;
  late TextEditingController? _descriptionTextController;

  double _commonFontSize = 12;

  @override
  void dispose() {
    if (_nameTextController != null) {
      _nameTextController!.dispose();
    }

    if (_descriptionTextController != null) {
      _descriptionTextController!.dispose();
    }

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initController();
  }

  void _initController() {
    final viewModel = context.read<CategoryViewModel>();
    _nameTextController =
        TextEditingController(text: viewModel.category?.name ?? "");
    _descriptionTextController =
        TextEditingController(text: viewModel.category?.description ?? "");
  }

  Widget get _deleteButton {
    return Consumer<CategoryViewModel>(
      builder: (context, viewModel, child) => IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => _showDeleteDialog(
          onAgreeDelete: () => viewModel.delete(context),
        ),
      ),
    );
  }

  Widget get _headerField {
    return Row(
      children: [
        Consumer<CategoryViewModel>(
          builder: (context, viewModel, child) => GestureDetector(
            onTap: () => _showImageActionSheet(),
            child: viewModel.image == null
                ? Container(
                    height: 80,
                    width: 80,
                    child: Icon(Icons.camera_alt_outlined),
                    decoration: new BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.all(
                        Radius.circular(40.0),
                      ),
                    ),
                  )
                : CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[900],
                    backgroundImage: MemoryImage(viewModel.image!),
                  ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: _nameField,
        ),
      ],
    );
  }

  Widget get _nameField {
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
            child: Consumer<CategoryViewModel>(
              builder: (context, viewModel, child) => CupertinoTextField(
                placeholder: "Enter product name",
                controller: _nameTextController,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                  fontSize: _commonFontSize,
                ),
                onChanged: (name) => viewModel.setName(name: name),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _descriptionField {
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
            child: Consumer<CategoryViewModel>(
              builder: (context, viewModel, child) => CupertinoTextField(
                controller: _descriptionTextController,
                placeholder: "Enter description",
                maxLines: null,
                textAlignVertical: TextAlignVertical.top,
                style: TextStyle(
                  fontSize: _commonFontSize,
                ),
                onChanged: (description) =>
                    viewModel.setDescription(description: description),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget get _listOfProducts {
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

  Widget get _actionSheet {
    return CupertinoActionSheet(
      title: Text("Choose an image for this category"),
      message: Text("Take a photo or select one from library"),
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.pop(context),
        child: Text("Cancel"),
        isDestructiveAction: true,
      ),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context, ActionSheetResult.camera),
          child: Text("Take a photo"),
        ),
        CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context, ActionSheetResult.library),
          child: Text("Select from library"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CategoryViewModel>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(viewModel.appBarTitle),
        actions: viewModel.isDeleteButtonVisible
            ? [
                _deleteButton,
              ]
            : [],
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
                        _headerField,
                        SizedBox(
                          height: 10,
                        ),
                        _descriptionField,
                        SizedBox(
                          height: 10,
                        ),
                        _listOfProducts,
                      ],
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: viewModel.isSaveButtonEnable
                          ? () => viewModel.save(context)
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 40),
                        child: Text(
                          viewModel.buttonTitle,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
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
                        backgroundColor: MaterialStateProperty.all<Color>(
                            viewModel.isSaveButtonEnable
                                ? Colors.blue
                                : Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog({required Function onAgreeDelete}) async {
    dynamic pop = await showDialog(
      context: this.context,
      builder: (context) {
        return CustomAlertDialog(
          title: "Delete this category?",
          content:
              "Are you sure that you want to delete this category?\nThis action can not be reverse!",
          successButtonTitle: "Delete",
          cancelButtonTitle: "Cancel",
        );
      },
    );

    if (pop != null) {
      AlertResult result = pop as AlertResult;
      if (pop == AlertResult.success) {
        onAgreeDelete();
      }
    }
  }

  void _showImageActionSheet() async {
    dynamic pop = await showCupertinoModalPopup(
        context: this.context,
        builder: (context) {
          return _actionSheet;
        });

    if (pop != null) {
      ActionSheetResult result = pop as ActionSheetResult;
      getImage(result: result);
    }
  }

  Future getImage({required ActionSheetResult result}) async {
    final viewModel = context.read<CategoryViewModel>();

    final pickedFile = await picker.getImage(
        source: result == ActionSheetResult.camera
            ? ImageSource.camera
            : ImageSource.gallery);

    if (pickedFile != null) {
      Uint8List image = await pickedFile.readAsBytes();
      viewModel.setFile(image: image);
    } else {
      print('No image selected.');
    }
  }
}
