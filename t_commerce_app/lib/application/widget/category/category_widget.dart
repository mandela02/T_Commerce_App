import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:t_commerce_app/application/app/app_router.dart';
import 'package:t_commerce_app/application/widget/category/action_sheet_result.dart';
import 'package:t_commerce_app/application/widget/category/category_view_model.dart';
import 'package:t_commerce_app/application/widget/reusable_wigdet/alert_dialog.dart';
import 'package:t_commerce_app/application/widget/reusable_wigdet/delete_button_widget.dart';
import 'package:t_commerce_app/application/widget/reusable_wigdet/intput_text_field_widget.dart';
import 'package:t_commerce_app/application/widget/reusable_wigdet/reusable_product_list_view_widget.dart';
import 'package:t_commerce_app/application/widget/reusable_wigdet/round_button_widget.dart';

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
        TextEditingController(text: viewModel.category?.categoryName ?? "");
    _descriptionTextController =
        TextEditingController(text: viewModel.category?.description ?? "");
  }

  Widget get _deleteButton {
    return Consumer<CategoryViewModel>(
      builder: (context, viewModel, child) => DeleteButtonWidget(
        onClick: () => _showDeleteDialog(
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
    return Consumer<CategoryViewModel>(
      builder: (context, viewModel, child) => InputTextFieldWidget(
          title: "Name *",
          placeholder: "Enter product name",
          height: 40,
          isMultiLine: false,
          size: _commonFontSize,
          controller: _nameTextController,
          keyboard: TextInputType.name,
          onTextChange: (name) => viewModel.setName(name: name)),
    );
  }

  Widget get _descriptionField {
    return Consumer<CategoryViewModel>(
      builder: (context, viewModel, child) => InputTextFieldWidget(
        title: "Description",
        placeholder: "Enter description",
        height: 200,
        isMultiLine: true,
        size: _commonFontSize,
        controller: _descriptionTextController,
        keyboard: TextInputType.multiline,
        onTextChange: (description) =>
            viewModel.setDescription(description: description),
      ),
    );
  }

  Widget get _listOfProducts {
    final viewModel = context.watch<CategoryViewModel>();

    if (viewModel.isDeleteButtonVisible) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Products in this category: ${viewModel.products.length} product",
            style: TextStyle(
              fontSize: _commonFontSize,
            ),
            textAlign: TextAlign.start,
          ),
          ReusableProductListViewWidget(
              products: viewModel.products,
              onCellTap: (product) async {
                await Navigator.pushNamed(context, AppRouter.PRODUCT,
                    arguments: product);
                viewModel.getProducts();
              })
        ],
      );
    } else {
      return Text(
        "Create a new product",
        style: TextStyle(
          fontSize: _commonFontSize,
        ),
        textAlign: TextAlign.start,
      );
    }
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
        child: Container(
          color: Colors.grey[100],
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
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
                        height: 20,
                      ),
                      _listOfProducts,
                    ],
                  ),
                ),
                Center(
                  child: RoundButtonWidget(
                      title: viewModel.buttonTitle,
                      backgroundColor: viewModel.isSaveButtonEnable
                          ? Colors.blue
                          : Colors.grey,
                      onClick: viewModel.isSaveButtonEnable
                          ? () => viewModel.save(context)
                          : null),
                ),
              ],
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
