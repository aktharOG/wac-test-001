import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    log("Database Initializing....");
    final String databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, 'wac_test.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    // Create your database tables and schema here
    await db.execute(
        """CREATE TABLE IF NOT EXISTS banner (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
         title TEXT,imageUrl TEXT,sku TEXT,productName TEXT,productImage TEXT,productRating INTEGER,
         actualPrice TEXT,offerPrice TEXT,discount,createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)""");
          await db.execute(
        """CREATE TABLE IF NOT EXISTS popular (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
         title TEXT,imageUrl TEXT,sku TEXT,productName TEXT,productImage TEXT,productRating INTEGER,
         actualPrice TEXT,offerPrice TEXT,discount,createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)""");
          await db.execute(
        """CREATE TABLE IF NOT EXISTS category (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
         title TEXT,imageUrl TEXT,sku TEXT,productName TEXT,productImage TEXT,productRating INTEGER,
         actualPrice TEXT,offerPrice TEXT,discount,createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)""");
          await db.execute(
        """CREATE TABLE IF NOT EXISTS featured (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
         title TEXT,imageUrl TEXT,sku TEXT,productName TEXT,productImage TEXT,productRating INTEGER,
         actualPrice TEXT,offerPrice TEXT,discount,createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)""");
  }

  // Future<int> insertData(String table, Map<String, dynamic> data) async {
  //   log("inserting data");
  //   final Database db = await instance.database;
  //   return await db.insert(table, data);
  // }
  Future<int> insertData(String table, Map<String, dynamic> data) async {
  log("inserting data");
  final int id = data['title']; // Assuming 'id' is the key for the ID field in the data map
  final Database db = await instance.database;

  final List<Map<String, dynamic>> existingData = await db.query(
    table,
    where: 'title = ?',
    whereArgs: [id],
    limit: 1,
  );

  if (existingData.isNotEmpty) {
    // ID already exists, perform update instead of insert
    return await db.update(
      table,
      data,
      where: 'title = ?',
      whereArgs: [id],
    );
  } else {
    // ID doesn't exist, perform insert
    return await db.insert(table, data);
  }
}

  Future<List<Map<String, dynamic>>> fetchData(String table) async {
    log("fetching data");
    final Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> deleteData(String table, int id) async {
    log("deleting data");
    final Database db = await instance.database;
    return await db.delete(table, where: 'title = ?', whereArgs: [id]);
  }

  // Add other methods for updating, deleting, and querying data

  Future<void> closeDatabase() async {
    final Database db = await instance.database;
    db.close();
    _database = null;
  }
}
