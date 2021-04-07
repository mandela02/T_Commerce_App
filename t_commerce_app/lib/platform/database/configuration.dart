import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:t_commerce_app/domain/model/category.dart';
import 'package:t_commerce_app/domain/model/category_of_product.dart';
import 'package:t_commerce_app/domain/model/image_of_product.dart';
import 'package:t_commerce_app/domain/model/product.dart';

abstract class TableName {
  static const String DATABASE_NAME = "STORE_DATABASE.db";
  static const String CATEGORY_TABLE_NAME = "CATEGORY_TABLE";
  static const String PRODUCT_TABLE_NAME = "PRODUCT_TABLE";
  static const String CATEGORY_OF_PRODUCT_TABLE_NAME =
      "CATEGORY_OF_PRODUCT_TABLE";
  static const String IMAGE_OF_PRODUCT_TABLE_NAME = "IMAGE_OF_PRODUCT_TABLE";
}

class Configuration {
  static final Configuration share = Configuration._();

  late final Future<Database> database;

  Configuration._() {
    database = openAppDatabase();
  }

  Future<Database> openAppDatabase() async {
    return openDatabase(join(await getDatabasesPath(), TableName.DATABASE_NAME),
        onCreate: (db, version) {
      _createTable(db, version);
    }, version: 1);
  }

  void _createTable(Database db, int newVersion) async {
    String createCategoryTable = """
        CREATE TABLE ${TableName.CATEGORY_TABLE_NAME} (
        ${CategoryRowName.id.name} TEXT PRIMARY KEY, 
        ${CategoryRowName.categoryName.name} TEXT, 
        ${CategoryRowName.description.name} TEXT, 
        ${CategoryRowName.memoryImage.name} BLOB
        )
        """;

    String createProductTable = """
        CREATE TABLE ${TableName.PRODUCT_TABLE_NAME}(
        ${ProductRowName.id.name} TEXT PRIMARY KEY, 
        ${ProductRowName.name.name} TEXT, 
        ${ProductRowName.sellPrice.name} INTEGER, 
        ${ProductRowName.discountPrice.name} INTEGER, 
        ${ProductRowName.importPrice.name} INTEGER, 
        ${ProductRowName.createDate.name} INTEGER, 
        ${ProductRowName.updateDate.name} INTEGER, 
        ${ProductRowName.barCode.name} TEXT, 
        ${ProductRowName.description.name} TEXT,
        ${ProductRowName.weight.name} INTEGER
        )
        """;

    String createCategoryOfProductTable = """
        CREATE TABLE ${TableName.CATEGORY_OF_PRODUCT_TABLE_NAME}(
        ${CategoryOfProductRowName.id.name} TEXT PRIMARY KEY, 
        ${CategoryOfProductRowName.categoryId.name} TEXT, 
        ${CategoryOfProductRowName.productId.name} TEXT
        )
        """;

    String createImageOfProduct = """
        CREATE TABLE ${TableName.IMAGE_OF_PRODUCT_TABLE_NAME}(
        ${ImageOfProductRowName.id.name} TEXT PRIMARY KEY, 
        ${ImageOfProductRowName.productId.name} TEXT,
        ${ImageOfProductRowName.memoryImage.name} BLOB, 
        ${ImageOfProductRowName.isAvatar.name} INTEGER,
        ${ImageOfProductRowName.assetIdentifier.name} TEXT,
        ${ImageOfProductRowName.assetName.name} TEXT,
        ${ImageOfProductRowName.assetOriginalWidth.name} INTEGER,
        ${ImageOfProductRowName.assetOriginalHeight.name} INTEGER
        )
        """;

    Batch batch = db.batch();
    batch.execute(createCategoryTable);
    batch.execute(createProductTable);
    batch.execute(createCategoryOfProductTable);
    batch.execute(createImageOfProduct);

    await batch.commit();
  }
}
