import 'package:sqflite/sqflite.dart';
import 'package:t_commerce_app/domain/model/model_type.dart';
import 'package:t_commerce_app/platform/repository/configuration.dart';

abstract class RepositoryType<T extends ModelType> {
  Future<List<Map<String, dynamic>>> getAll(String table);
  Future<void> insert(T object, String table);
  Future<void> delete(String field, String arg, String table);
  Future<void> update(T object, String field, String arg, String table);
}

class Repository<T extends ModelType> implements RepositoryType {
  final Configuration configuration;
  Repository() : configuration = Configuration.share;

  @override
  Future<void> insert(ModelType object, String table) async {
    final Database db = await configuration.database;
    await db.insert(
      table,
      object.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getAll(String table) async {
    final Database db = await configuration.database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    List<Map<String, dynamic>> result = maps;
    return result;
  }

  @override
  Future<void> delete(String field, String arg, String table) async {
    final Database db = await configuration.database;
    await db.delete(
      table,
      where: "$field = ?",
      whereArgs: [arg],
    );
  }

  @override
  Future<void> update(
      ModelType object, String field, String arg, String table) async {
    // TODO: implement update
    final Database db = await configuration.database;
    await db.update(
      table,
      object.toMap(),
      where: "$field = ?",
      whereArgs: [arg],
    );
  }
}
