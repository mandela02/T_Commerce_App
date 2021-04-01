import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:t_commerce_app/application/app/app_router.dart';
import 'package:t_commerce_app/application/widget/product/product_view_model.dart';
import 'package:t_commerce_app/application/widget/reusable_wigdet/delete_button_widget.dart';
import 'package:t_commerce_app/application/widget/reusable_wigdet/intput_text_field_widget.dart';
import 'package:t_commerce_app/application/widget/reusable_wigdet/round_button_widget.dart';
import 'package:t_commerce_app/domain/model/category.dart';

class ProductWidget extends StatefulWidget {
  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  double _commonFontSize = 12;

  late TextEditingController _barCodeTextController;
  late TextEditingController _nameTextController;
  late TextEditingController _originalPriceTextController;
  late TextEditingController _discountTextController;
  late TextEditingController _descriptionTextController;

  List<Asset> _images = [];

  @override
  void initState() {
    super.initState();
    final viewModel = context.read<ProductViewModel>();
    viewModel.getCategories();
    _barCodeTextController = TextEditingController(text: viewModel.barCode);
    _nameTextController = TextEditingController(text: viewModel.name);
    _originalPriceTextController =
        TextEditingController(text: viewModel.originalPrice);
    _discountTextController =
        TextEditingController(text: viewModel.discountPrice);
    _descriptionTextController =
        TextEditingController(text: viewModel.description);
  }

  @override
  void dispose() {
    _barCodeTextController.dispose();
    _nameTextController.dispose();
    _originalPriceTextController.dispose();
    _discountTextController.dispose();
    _descriptionTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProductViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text("New Product"),
        actions: viewModel.isDeleteButtonVisible
            ? [
                DeleteButtonWidget(onClick: () => {}),
              ]
            : [],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Scrollbar(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      _imagesWidget,
                      SizedBox(height: 20),
                      _nameWidget,
                      SizedBox(height: 20),
                      _categoryPicker,
                      SizedBox(height: 20),
                      _priceWidget,
                      SizedBox(height: 20),
                      _barCodeWidget,
                      SizedBox(height: 20),
                      _descriptionWidget,
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
                          ? () => viewModel.saveProduct(context)
                          : null),
                )
              ],
            ),
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

  Widget get _priceWidget {
    return Consumer<ProductViewModel>(
      builder: (context, viewModel, child) => Row(
        children: [
          Expanded(
            flex: 1,
            child: InputTextFieldWidget(
              title: "Original Price",
              placeholder: "Enter price",
              height: 40,
              isMultiLine: false,
              size: _commonFontSize,
              controller: _originalPriceTextController,
              keyboard: TextInputType.number,
              onTextChange: (price) => viewModel.setOriginalPrice(price: price),
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
          Container(
            height: 65,
            child: TextButton(
              onPressed: () => _scanBarcodeNormal(),
              child: Icon(Icons.qr_code),
            ),
          ),
        ],
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
                  onTap: _showImageActionSheet,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      viewModel.selectedCategory == null
                          ? "Choose a category"
                          : viewModel.selectedCategory!.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          color: Colors.blue),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 60,
            child: TextButton(
              onPressed: () => _createNewCategory(),
              child: Icon(Icons.category),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _imagesWidget {
    return Consumer<ProductViewModel>(
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
            CupertinoButton(
              child: Text("Select Image"),
              onPressed: () => loadAssets(),
            ),
          ],
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

  void _showImageActionSheet() async {
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
                  child: Text(e.name.toUpperCase()),
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
      {required Uint8List? image,
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
                  image: MemoryImage(image),
                ),
        ),
      ),
    );
  }

  Future<void> loadAssets() async {
    final viewModel = context.read<ProductViewModel>();

    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';
    print("load");
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: _images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
      print(error);
    }
    if (!mounted) return;

    final dataList = resultList.map(
      (e) async {
        final data = await e.getByteData();
        return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      },
    ).toList();

    final realDataList = await Future.wait(dataList);

    _images = resultList;
    viewModel.setListImages(images: realDataList);
  }
}
