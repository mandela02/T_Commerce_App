import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:t_commerce_app/application/app/app_router.dart';
import 'package:t_commerce_app/application/widget/product/product_view_model.dart';
import 'package:t_commerce_app/application/widget/reusable_wigdet/alert_dialog.dart';
import 'package:t_commerce_app/application/widget/reusable_wigdet/delete_button_widget.dart';
import 'package:t_commerce_app/application/widget/reusable_wigdet/intput_text_field_widget.dart';
import 'package:t_commerce_app/application/widget/reusable_wigdet/round_button_widget.dart';
import 'package:t_commerce_app/application/widget/reusable_wigdet/round_icon_button_widget.dart';
import 'package:t_commerce_app/domain/model/category.dart';
import 'package:t_commerce_app/domain/model/image_object.dart';

class ProductWidget extends StatefulWidget {
  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  double _commonFontSize = 12;

  late TextEditingController _barCodeTextController;
  late TextEditingController _nameTextController;
  late TextEditingController _sellPriceTextController;
  late TextEditingController _discountTextController;
  late TextEditingController _descriptionTextController;
  late TextEditingController _weightTextController;
  late TextEditingController _importPriceTextController;

  @override
  void initState() {
    super.initState();
    final viewModel = context.read<ProductViewModel>();
    viewModel.getCategories();
    _barCodeTextController = TextEditingController(text: viewModel.barCode);
    _nameTextController = TextEditingController(text: viewModel.name);
    _sellPriceTextController = TextEditingController(text: viewModel.sellPrice);
    _discountTextController =
        TextEditingController(text: viewModel.discountPrice);
    _descriptionTextController =
        TextEditingController(text: viewModel.description);
    _weightTextController = TextEditingController(text: viewModel.weight);
    _importPriceTextController =
        TextEditingController(text: viewModel.importPrice);
  }

  @override
  void dispose() {
    _barCodeTextController.dispose();
    _nameTextController.dispose();
    _sellPriceTextController.dispose();
    _discountTextController.dispose();
    _descriptionTextController.dispose();
    _weightTextController.dispose();
    _importPriceTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProductViewModel>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(viewModel.appBarTitle),
        actions: viewModel.isDeleteButtonVisible
            ? [
                DeleteButtonWidget(onClick: () => _delete()),
              ]
            : [],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        color: Colors.grey[100],
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    _imagesWidget,
                    SizedBox(height: 10),
                    _generalInformationWidget,
                    SizedBox(height: 10),
                    _allPriceWidget,
                    SizedBox(height: 10),
                    _sizeWidget,
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: RoundButtonWidget(
                    title: viewModel.buttonTitle,
                    backgroundColor: viewModel.isSaveButtonEnable
                        ? Colors.blue
                        : Colors.grey,
                    onClick: viewModel.isSaveButtonEnable
                        ? () => viewModel.saveProduct(context)
                        : null),
              )
            ],
          ),
        ),
      ),
    );
  }

  void setStateIfNeeded(Function function) {
    setState(() => function());
  }
}

extension ProductWidgetComputedPropeties on _ProductWidgetState {
  Widget get _generalInformationWidget {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _nameWidget,
            SizedBox(height: 20),
            _categoryPicker,
            SizedBox(height: 20),
            _barCodeWidget,
            SizedBox(height: 20),
            _descriptionWidget,
          ],
        ),
      ),
    );
  }

  Widget get _nameWidget {
    return Consumer<ProductViewModel>(
      builder: (context, viewModel, child) => InputTextFieldWidget(
        title: "Name*",
        placeholder: "Enter production name",
        height: 40,
        isMultiLine: false,
        size: _commonFontSize,
        controller: _nameTextController,
        keyboard: TextInputType.text,
        onTextChange: (name) => viewModel.setName(name: name),
      ),
    );
  }

  Widget get _descriptionWidget {
    return Consumer<ProductViewModel>(
      builder: (context, viewModel, child) => InputTextFieldWidget(
        title: "Description",
        placeholder: "Enter production description",
        height: 200,
        isMultiLine: true,
        size: _commonFontSize,
        controller: _descriptionTextController,
        keyboard: TextInputType.text,
        onTextChange: (description) =>
            viewModel.setDescription(description: description),
      ),
    );
  }

  Widget get _allPriceWidget {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _sellPriceWidget,
            SizedBox(
              height: 20,
            ),
            _importPriceWidget,
          ],
        ),
      ),
    );
  }

  Widget get _sellPriceWidget {
    return Consumer<ProductViewModel>(
      builder: (context, viewModel, child) => Row(
        children: [
          Expanded(
            flex: 1,
            child: InputTextFieldWidget(
              title: "Sell Price",
              placeholder: "Enter price",
              height: 40,
              isMultiLine: false,
              size: _commonFontSize,
              controller: _sellPriceTextController,
              keyboard: TextInputType.number,
              onTextChange: (price) => viewModel.setSellPrice(price: price),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            flex: 1,
            child: InputTextFieldWidget(
              title: "Discount Price",
              placeholder: "Enter price",
              height: 40,
              isMultiLine: false,
              size: _commonFontSize,
              controller: _discountTextController,
              keyboard: TextInputType.number,
              onTextChange: (price) => viewModel.setDiscountPrice(price: price),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _importPriceWidget {
    return Consumer<ProductViewModel>(
      builder: (context, viewModel, child) => Row(
        children: [
          Expanded(
            flex: 1,
            child: InputTextFieldWidget(
              title: "Import Price",
              placeholder: "Enter price",
              height: 40,
              isMultiLine: false,
              size: _commonFontSize,
              controller: _importPriceTextController,
              keyboard: TextInputType.number,
              onTextChange: (price) => viewModel.setImportPrice(price: price),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Revenue",
                  style: TextStyle(
                    fontSize: _commonFontSize,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  viewModel.calculateRevenue(),
                  style: TextStyle(
                    fontSize: _commonFontSize,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget get _barCodeWidget {
    return Consumer<ProductViewModel>(
      builder: (context, viewModel, child) => Row(
        children: [
          Expanded(
            child: InputTextFieldWidget(
              title: "Barcode",
              placeholder: "Enter this product's barcode",
              height: 40,
              isMultiLine: false,
              size: _commonFontSize,
              controller: _barCodeTextController,
              keyboard: TextInputType.text,
              onTextChange: (code) => viewModel.setBarCode(barCode: code),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          RoundIconButtonWidget(
            width: 65,
            height: 65,
            cornerRadius: Radius.circular(10),
            tintColor: Colors.white,
            backgroundColor: Colors.blue,
            icon: Icons.qr_code_outlined,
            onButtonTap: _scanBarcodeNormal,
          ),
        ],
      ),
    );
  }

  Widget get _sizeWidget {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            _weightWidget,
          ],
        ),
      ),
    );
  }

  Widget get _weightWidget {
    return Consumer<ProductViewModel>(
      builder: (context, viewModel, child) => InputTextFieldWidget(
        title: "Weight (g)",
        placeholder: "Enter production weight",
        height: 40,
        isMultiLine: false,
        size: _commonFontSize,
        controller: _weightTextController,
        keyboard: TextInputType.numberWithOptions(decimal: true),
        onTextChange: (weight) => viewModel.setWeight(weight: weight),
      ),
    );
  }

  Widget get _categoryPicker {
    return Consumer<ProductViewModel>(
      builder: (context, viewModel, child) => Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Category",
                  style: TextStyle(
                    fontSize: _commonFontSize,
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: _showCategoryActionSheet,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      viewModel.selectedCategory == null
                          ? "Choose a category"
                          : viewModel.selectedCategory!.categoryName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.blue),
                    ),
                  ),
                )
              ],
            ),
          ),
          RoundIconButtonWidget(
            width: 65,
            height: 65,
            cornerRadius: Radius.circular(10),
            tintColor: Colors.white,
            backgroundColor: Colors.blue,
            icon: Icons.category_outlined,
            onButtonTap: _createNewCategory,
          ),
        ],
      ),
    );
  }

  Widget get _imagesWidget {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<ProductViewModel>(
        builder: (context, viewModel, child) => Center(
          child: Column(
            children: [
              createImageWidget(
                image: viewModel.selectedImage,
                isInList: false,
                imageSize: 150,
              ),
              SizedBox(height: 20),
              Container(
                height: 85,
                child: Row(
                  children: [
                    RoundIconButtonWidget(
                        backgroundColor: Colors.blue,
                        tintColor: Colors.white,
                        width: 60,
                        height: 60,
                        cornerRadius: Radius.circular(10),
                        icon: Icons.add_a_photo_outlined,
                        onButtonTap: loadAssets),
                    SizedBox(width: 10),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: viewModel.images.length,
                        itemBuilder: (context, index) {
                          final asset = viewModel.images[index];
                          return createImageWidget(
                            image: asset,
                            isInList: true,
                            imageSize: 65,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension ProductWidgetFunction on _ProductWidgetState {
  void _createNewCategory() async {
    final viewModel = context.read<ProductViewModel>();
    await Navigator.pushNamed(context, AppRouter.CATEGORY);
    viewModel.getCategories();
  }

  Future<void> _scanBarcodeNormal() async {
    final viewModel = context.read<ProductViewModel>();

    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    viewModel.setBarCode(barCode: barcodeScanRes);
    setStateIfNeeded(() => _barCodeTextController.text = viewModel.barCode);
  }

  void _showCategoryActionSheet() async {
    final viewModel = context.read<ProductViewModel>();

    dynamic pop = await showCupertinoModalPopup(
        context: this.context,
        builder: (context) {
          return _getActionSheet();
        });

    if (pop != null) {
      final result = pop as Category;
      viewModel.setSelectedCategory(category: result);
    }
  }

  Widget _getActionSheet() {
    final viewModel = context.read<ProductViewModel>();
    final categories = viewModel.categories;

    return CupertinoActionSheet(
      title: Text("Choose an category!"),
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.pop(context),
        child: Text("Cancel"),
        isDestructiveAction: true,
      ),
      actions: categories
              .map(
                (e) => CupertinoActionSheetAction(
                  onPressed: () => Navigator.pop(context, e),
                  child: Text(e.categoryName.toUpperCase()),
                ),
              )
              .toList() +
          [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                _createNewCategory();
              },
              child: Text("Create new category"),
            )
          ],
    );
  }

  Widget createImageWidget(
      {required ImageObject? image,
      required bool isInList,
      required double imageSize}) {
    final viewModel = context.watch<ProductViewModel>();

    return GestureDetector(
      onTap: () {
        if (viewModel.images.isNotEmpty) {
          viewModel.setSelectedImage(image: image);
        }
      },
      child: Container(
        padding: EdgeInsets.all(2),
        margin: EdgeInsets.all(10),
        width: imageSize,
        height: imageSize,
        decoration: BoxDecoration(
          color:
              viewModel.selectedImage == image && isInList ? Colors.red : null,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          child: image == null
              ? Container(
                  color: Colors.grey[200],
                  child: Icon(
                    Icons.camera_alt_outlined,
                  ),
                )
              : Image(
                  fit: BoxFit.cover,
                  image: MemoryImage(image.memory),
                ),
        ),
      ),
    );
  }

  Future<void> loadAssets() async {
    final viewModel = context.read<ProductViewModel>();

    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 6,
        enableCamera: true,
        selectedAssets: viewModel.assets,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "T Commerce App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );

      if (!mounted) return;
      viewModel.setAssets(images: resultList);
    } on Exception catch (e) {
      error = e.toString();
      print(error);
    }
  }

  Future<void> _delete() async {
    final viewModel = context.read<ProductViewModel>();
    dynamic pop = await showDialog(
      context: this.context,
      builder: (context) {
        return CustomAlertDialog(
          title: "Delete this product?",
          content:
              "Are you sure that you want to delete this product?\nThis action can not be reverse!",
          successButtonTitle: "Delete",
          cancelButtonTitle: "Cancel",
        );
      },
    );

    if (pop != null) {
      AlertResult result = pop as AlertResult;
      if (result == AlertResult.success) {
        await viewModel.delete(context);
      }
    }
  }
}
