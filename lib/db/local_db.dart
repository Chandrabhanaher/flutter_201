import 'package:path/path.dart' as path;

import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class LocalDB {
  static final LocalDB instance = LocalDB._getDatabase();
  static Database? _database;
  LocalDB._getDatabase();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _getDatabase('app_database.db');
    return _database!;
  }

  Future<Database> _getDatabase(String dbName) async {
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbPath, dbName),
      onCreate: _onCreate,
      version: 1,
    );
    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE user_cart(id INTEGER PRIMARY KEY AUTOINCREMENT, pid TEXT)');
    await db.execute(
        'CREATE TABLE user_wish(id INTEGER PRIMARY KEY AUTOINCREMENT, pid TEXT)');
  }

  Future<void> addCart(Map<String, dynamic> data) async {
    final db = await instance.database;
    await db.insert('user_cart', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  Future<void> addWish(Map<String, dynamic> data) async {
    final db = await instance.database;
    await db.insert('user_wish', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getAllCartItems() async {
    final db = await instance.database;
    return db.query('user_cart');
  }

  Future<List<Map<String, dynamic>>> getAllFavItems() async {
    final db = await instance.database;
    return db.query('user_wish');
  }

  Future<void> deleteCartItem(String id) async {
    final db = await instance.database;
    await db.delete('user_cart', where: 'pid = ?', whereArgs: [id]);
  }

  Future<void> deleteFavItem(String id) async {
    final db = await instance.database;
    await db.delete('user_wish', where: 'pid = ?', whereArgs: [id]);
  }
}
