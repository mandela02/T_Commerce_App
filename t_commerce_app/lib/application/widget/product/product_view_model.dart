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
  String _originalPrice = "";
  String _discountPrice = "";
  String _barCode = "";

  ProductViewModel({required Product? product, required Category? category}) {
    this._product = product;
    this._selectedCategory = category;

    if (_product != null) {
      final notNullProduct = _product!;
      setName(name: notNullProduct.name);
      setDescription(description: notNullProduct.description);
      setOriginalPrice(price: "${notNullProduct.originalPrice}");
      setDiscountPrice(price: "${notNullProduct.discountPrice}");
      setBarCode(barCode: notNullProduct.barCode);
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
      _images = imageList;
      _selectedImage =
          ImageObject(memory: selected.memoryImage, asset: selected.assetImage);
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

  void saveProduct(BuildContext context) async {
    int now = DateTime.now().millisecondsSinceEpoch;
    int originalPrice = 0;
    int discountPrice = 0;

    try {
      originalPrice = int.parse(_originalPrice);
    } catch (e) {
      originalPrice = 999999;
    }

    try {
      discountPrice = int.parse(_discountPrice);
    } catch (e) {
      discountPrice = discountPrice;
    }

    if (_product == null) {
      final Product product = Product.create(
          name: _name,
          originalPrice: originalPrice,
          discountPrice: discountPrice,
          createDate: now,
          updateDate: now,
          barCode: _barCode,
          description: _description);
      if (_selectedCategory != null && _selectedImage != null) {
        await _useCase.save(
            product: product,
            category: _selectedCategory!,
            avatar: _selectedImage!,
            images: _images);
      }
    } else {
      Product existProduct = _product!;
      final Product product = Product(
          id: existProduct.id,
          name: _name,
          originalPrice: originalPrice,
          discountPrice: discountPrice,
          createDate: existProduct.createDate,
          updateDate: now,
          barCode: _barCode,
          description: _description);
      if (_selectedCategory != null && _selectedImage != null) {
        await _useCase.update(
            product: product,
            category: _selectedCategory!,
            avatar: _selectedImage!,
            images: _images);
      }
    }
    Navigator.pop(context);
  }
}

extension ProductViewModelGetter on ProductViewModel {
  String get name => _name;
  String get description => _description;
  String get originalPrice => _originalPrice;
  String get discountPrice => _discountPrice;
  String get barCode => _barCode;
  String get appBarTitle => _product == null ? "New product" : _product!.name;
  String get buttonTitle => _product == null ? "Create" : "Update";
  bool get isSaveButtonEnable =>
      _name.isNotEmpty &&
      _selectedCategory != null &&
      _originalPrice.isNotEmpty &&
      _selectedImage != null;
  bool get isDeleteButtonVisible => _product != null;
  List<Category> get categories => _categories;
  Category? get selectedCategory => _selectedCategory;
  List<ImageObject> get images => _images;
  ImageObject? get selectedImage => _selectedImage;
  List<Asset> get assets => _assets;
}

extension ProductViewModelSetter on ProductViewModel {
  void setSelectedCategory({required Category? category}) {
    this._selectedCategory = category;
    change();
  }

  void setBarCode({required String barCode}) {
    _barCode = barCode;
    change();
  }

  void setDiscountPrice({required String price}) {
    _discountPrice = price;
    change();
  }

  void setOriginalPrice({required String price}) {
    _originalPrice = price;
    change();
  }

  void setDescription({required String description}) {
    _description = description;
    change();
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
}

extension ProductViewModelFunction on ProductViewModel {
  void _updateSelectedImage() {
    if (images.isNotEmpty &&
        (selectedImage == null || !images.contains(selectedImage))) {
      _selectedImage = images.first;
    } else if (images.isEmpty) {
      _selectedImage = null;
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
}
