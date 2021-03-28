import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class TableName {
  static String databaseName = "store_database.db";
  static String categoryTableName = "category";
  static String productTableName = "product";
  static String categoryOfProductTableName = "category_of_product";
}

class Configuration {
  static final Configuration share = Configuration._();

  late final Future<Database> database;

  Configuration._() {
    database = openAppDatabase();
  }

  Future<Database> openAppDatabase() async {
    return openDatabase(join(await getDatabasesPath(), TableName.databaseName),
        onCreate: (db, version) {
      _createTable(db, version);
    }, version: 1);
  }

  void _createTable(Database db, int newVersion) async {
    String createCategoryTable = """
        CREATE TABLE ${TableName.categoryTableName} (
        id TEXT PRIMARY KEY, 
        name TEXT, 
        description TEXT, 
        image BLOB
        )
        """;

    String createProductTable = """
        CREATE TABLE ${TableName.productTableName}(
        id TEXT PRIMARY KEY, 
        name TEXT, 
        originalPrice INTEGER, 
        discountPrice INTEGER, 
        createDate INTEGER, 
        updateDate INTEGER, 
        String TEXT, 
        description TEXT 
        )
        """;

    String createCategoryOfProductTable = """
        CREATE TABLE ${TableName.categoryOfProductTableName}(
        id TEXT PRIMARY KEY, 
        categoryId TEXT, 
        productId TEXT
        )
        """;

    Batch batch = db.batch();
    batch.execute(createCategoryTable);
    batch.execute(createProductTable);
    batch.execute(createCategoryOfProductTable);

    await batch.commit();
  }
}
