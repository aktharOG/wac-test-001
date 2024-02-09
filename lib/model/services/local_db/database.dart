// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:wac_test_001/model/services/local_db/db_dao.dart';

// part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [ContentDao])
abstract class AppDatabase extends FloorDatabase {
  ContentDao get personDao;
}