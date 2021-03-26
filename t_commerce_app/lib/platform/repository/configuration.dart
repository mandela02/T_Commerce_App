import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:t_commerce_app/domain/model/category.dart';

class Configuration {
  static final Configuration share = Configuration._();

  late final Future<Database> database;

  String _databaseName = "store_database.db";
  String _categoryTableName = "category";
  String _productTableName = "product";
  String _categoryOfProductTableName = "category_of_product";

  Configuration._() {
    database = openAppDatabase();
  }

  Future<Database> openAppDatabase() async {
    return openDatabase(join(await getDatabasesPath(), _databaseName),
        onCreate: (db, version) {
      _createTable(db, version);
    }, version: 1);
  }

  void _createTable(Database db, int newVersion) async {
    String createCategoryTable = """
        CREATE TABLE $_categoryTableName(
        id TEXT PRIMARY KEY, 
        name TEXT
        )
        """;

    String createProductTable = """
        CREATE TABLE $_productTableName(
        id TEXT PRIMARY KEY, 
        name TEXT, 
        originalPrice INTEGER, 
        discountPrice INTEGER, 
        createDate INTEGER, 
        updateDate INTEGER, 
        String TEXT, 
        name TEXT 
        )
        """;

    String createCategoryOfProductTable = """
        CREATE TABLE $_categoryOfProductTableName(
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

  Future<void> insertCategory(Category category) async {
    final Database db = await database;
    await db.insert(
      _categoryTableName,
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
