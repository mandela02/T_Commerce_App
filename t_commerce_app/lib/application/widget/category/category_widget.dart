import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t_commerce_app/application/widget/category/category_view_model.dart';
import 'package:t_commerce_app/application/widget/reusable_wigdet/alert_dialog.dart';

class CategoryWidget extends StatefulWidget {
  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
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

  Widget get deleteButton {
    return Consumer<CategoryViewModel>(
      builder: (context, viewModel, child) => IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => onDeleteWidget(
          onAgreeDelete: () => viewModel.delete(context),
        ),
      ),
    );
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
    final viewModel = context.watch<CategoryViewModel>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(viewModel.appBarTitle),
        actions: viewModel.isDeleteButtonVisible
            ? [
                deleteButton,
              ]
            : [deleteButton],
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

  void onDeleteWidget({required Function onAgreeDelete}) {
    showDialog(
      context: this.context,
      builder: (content) {
        return CustomAlertDialog(
            title: "Delete this category?",
            content:
                "Are you sure that you want to delete this category?\nThis action can not be reverse!",
            successButtonTitle: "Delete",
            onSuccess: () => onAgreeDelete(),
            cancelButtonTitle: "Cancel",
            onCancel: () {});
      },
    );
  }
}
