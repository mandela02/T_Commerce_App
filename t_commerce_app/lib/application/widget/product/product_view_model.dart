import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:t_commerce_app/domain/model/category.dart';
import 'package:t_commerce_app/domain/model/image_object.dart';
import 'package:t_commerce_app/domain/model/product.dart';
import 'package:t_commerce_app/domain/use_case/product_use_case_type.dart';
import 'package:t_commerce_app/domain/use_case/use_case_provider.dart';

class ProductViewModel extends ChangeNotifier {
  ProductUseCaseType _useCase = UseCaseProvider().getProductUseCase();

  List<Category> _categories = [];
  List<ImageObject> _images = [];
  List<Asset> _assets = [];

  ImageObject? _selectedImage;

  Category? _selectedCategory;
  Product? _product;

  String _name = "";
  String _description = "";
  String _sellPrice = "";
  String _discountPrice = "";
  String _importPrice = "";

  String? _barCode;
  String _weight = "";
  String _quantity = "";
  String _unit = "";

  ProductViewModel({required Product? product, required Category? category}) {
    this._product = product;
    this._selectedCategory = category;

    if (_product != null) {
      final notNullProduct = _product!;
      setName(name: notNullProduct.name);
      setDescription(description: notNullProduct.description);
      setImportPrice(price: "${notNullProduct.importPrice}");
      setSellPrice(price: "${notNullProduct.sellPrice}");
      setBarCode(barCode: notNullProduct.barCode);
      setWeight(weight: "${notNullProduct.weight}");
      setDiscountPrice(
          price: notNullProduct.discountPrice == null
              ? ""
              : "${notNullProduct.discountPrice}");
      setQuantity(quantity: "${notNullProduct.quantity}");
      setUnit(unit: notNullProduct.unit);
    }
    getImages();
  }

  void getImages() async {
    if (_product != null) {
      final notNullProduct = _product!;
      final dataImages = await _useCase.getAllImage(product: notNullProduct);
      final imageList = dataImages
          .map((e) => ImageObject(memory: e.memoryImage, asset: e.assetImage))
          .toList();
      final selected = dataImages.firstWhere((element) => element.isAvatar);
      setListImages(images: imageList);

      setSelectedImage(
          image: imageList
              .where((element) =>
                  element.asset == selected.assetImage &&
                  element.memory == selected.memoryImage)
              .toList()
              .first);

      setAssets(
          images: imageList
              .map((e) => e.asset)
              .where((element) => element != null)
              .map((e) => e!)
              .toList());
      change();
    }
  }

  void getCategories() async {
    List<Category> categories = await _useCase.getAllCategory();
    _categories = categories;
    notifyListeners();
  }

  void change() {
    notifyListeners();
  }
}

extension ProductViewModelGetter on ProductViewModel {
  String get name => _name;
  String get description => _description;
  String get sellPrice => _sellPrice;
  String get discountPrice => _discountPrice;
  String? get barCode => _barCode;
  String get appBarTitle => _product == null ? "New product" : _product!.name;
  String get buttonTitle => _product == null ? "Create" : "Update";
  bool get isSaveButtonEnable =>
      _name.isNotEmpty &&
      _selectedCategory != null &&
      _sellPrice.isNotEmpty &&
      _selectedImage != null &&
      _quantity.isNotEmpty &&
      _unit.isNotEmpty &&
      _importPrice.isNotEmpty &&
      _weight.isNotEmpty;
  bool get isDeleteButtonVisible => _product != null;
  List<Category> get categories => _categories;
  Category? get selectedCategory => _selectedCategory;
  List<ImageObject> get images => _images;
  ImageObject? get selectedImage => _selectedImage;
  List<Asset> get assets => _assets;
  String get weight => _weight;
  String get importPrice => _importPrice;
  String get quantity => _quantity;
  String get unit => _unit;
}

extension ProductViewModelSetter on ProductViewModel {
  void setSelectedCategory({required Category? category}) {
    this._selectedCategory = category;
    change();
  }

  void setBarCode({required String? barCode}) {
    _barCode = barCode;
  }

  void setDiscountPrice({required String price}) {
    _discountPrice = price;
    change();
  }

  void setSellPrice({required String price}) {
    _sellPrice = price;
    change();
  }

  void setImportPrice({required String price}) {
    _importPrice = price;
    change();
  }

  void setDescription({required String description}) {
    _description = description;
  }

  void setName({required String name}) {
    _name = name;
    change();
  }

  void setSelectedImage({required ImageObject? image}) {
    _selectedImage = image;
    change();
  }

  void setListImages({required List<ImageObject> images}) {
    _images = images;
    _updateSelectedImage();
    change();
  }

  void setAssets({required List<Asset> images}) async {
    _assets = images;
    await _fromAssetToImage();
    change();
  }

  void setWeight({required String weight}) {
    _weight = weight;
    change();
  }

  void setQuantity({required String quantity}) {
    _quantity = quantity;
    change();
  }

  void setUnit({required String unit}) {
    _unit = unit;
    change();
  }
}

extension ProductViewModelFunction on ProductViewModel {
  void _updateSelectedImage() {
    if (images.isNotEmpty &&
        (selectedImage == null || !images.contains(selectedImage))) {
      setSelectedImage(image: images.first);
    } else if (images.isEmpty) {
      setSelectedImage(image: null);
    }
  }

  Future<void> _fromAssetToImage() async {
    final resultList = _assets;
    final dataList = resultList.map(
      (e) async {
        final data = await e.getByteData();
        return ImageObject(
            asset: e,
            memory: data.buffer
                .asUint8List(data.offsetInBytes, data.lengthInBytes));
      },
    ).toList();
    final realDataList = await Future.wait(dataList);
    setListImages(images: realDataList);
  }

  Future<void> delete(BuildContext context) async {
    if (_product != null) {
      await _useCase.delete(product: _product!);
      Navigator.pop(context);
    }
  }

  void saveProduct(BuildContext context) async {
    int now = DateTime.now().millisecondsSinceEpoch;
    int sellPrice = 0;
    int? discountPrice;
    int importPrice;
    int weight;
    int quantity;

    try {
      sellPrice = int.parse(this.sellPrice);
      discountPrice = int.parse(this.discountPrice);
      importPrice = int.parse(this.importPrice);
      weight = int.parse(this.weight);
      quantity = int.parse(this.quantity);
    } catch (e) {
      sellPrice = 999999;
      discountPrice = null;
      importPrice = 999999;
      weight = 999;
      quantity = 1;
    }

    if (_product == null) {
      final Product product = Product.create(
          name: this.name,
          sellPrice: sellPrice,
          discountPrice: discountPrice,
          importPrice: importPrice,
          createDate: now,
          updateDate: now,
          barCode:
              this.barCode == null || this.barCode == "" ? null : this.barCode,
          description: this.description,
          weight: weight,
          quantity: quantity,
          unit: this.unit);
      if (this.selectedCategory != null && this.selectedImage != null) {
        await _useCase.save(
            product: product,
            category: this.selectedCategory!,
            avatar: this.selectedImage!,
            images: this.images);
        Navigator.pop(context);
      }
    } else {
      Product existProduct = _product!;
      final Product product = Product(
          id: existProduct.id,
          name: this.name,
          sellPrice: sellPrice,
          discountPrice: discountPrice,
          importPrice: importPrice,
          createDate: existProduct.createDate,
          updateDate: now,
          barCode:
              this.barCode == null || this.barCode == "" ? null : this.barCode,
          description: this.description,
          weight: weight,
          quantity: quantity,
          unit: this.unit);

      if (this.selectedCategory != null && this.selectedImage != null) {
        await _useCase.update(
            product: product,
            category: this.selectedCategory!,
            avatar: this.selectedImage!,
            images: this.images);
        Navigator.pop(context);
      }
    }
  }

  String calculateRevenue() {
    int sellPrice = 0;
    int importPrice = 0;
    int? discountPrice;

    try {
      sellPrice = int.parse(this.sellPrice);
      importPrice = int.parse(this.importPrice);
      discountPrice = int.parse(this.discountPrice);
    } catch (e) {
      sellPrice = 999999;
      importPrice = 999999;
      discountPrice = null;
    }

    return discountPrice == null
        ? "${sellPrice - importPrice}"
        : "${discountPrice - importPrice}";
  }
}
