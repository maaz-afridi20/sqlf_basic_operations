import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  //variables
  static const dbName = "firstdbb.db";

  static const dbVersion = 1;

  static const dbTable = "myTable";
  static const columnId = "id";
  static const columnName = "name";

// constructor..
  static final DatabaseHelper instance = DatabaseHelper();

  // initializing our database..

  static Database? _database;

  Future<Database?> get database async {
    // so basically this will do that if the database with same name
    // exist it will add the comming data in that database

    // but if not then it will create the databse with that name.
    //
    //
    // for doing this we have two logics both give below.
    _database ??= await initDB();
    return _database;

    // if (_database != null) {
    //   log('databse is not null');

    //   return _database;
    // } else {
    //   log('databse was null');
    //   _database = await initDB();
    //   return _database;
    // }
  }

  // so this method will be called when after above if else statement
  // so in this it will return the onCreate method
  // in which we have created a table with CREATE TABLE and putting
  // all the variables which we have creted above.

  initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);

    return await openDatabase(path, onCreate: onCreate, version: dbVersion);
  }

// this method will create a table with name which we will provide.
// when we call this method.
  Future onCreate(Database db, int version) async {
    db.execute('''   
      CREATE TABLE $dbTable (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL
      )
  ''');
  }

  // for inserting some data

  insertRecord(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(dbTable, row);
  }

  // for read or may be query method

  Future<List<Map<String, dynamic>>> queryDatabase() async {
    Database? db = await instance.database;
    return await db!.query(dbTable);
  }

  // update method.
  // for updating some data into database.

  Future<int> updateRecord(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[columnId];
    return await db!.update(
      dbTable,
      row,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

// for deleting some data into databse

  Future<int> deleteRecord(int id) async {
    Database? db = await instance.database;
    return await db!.delete(
      dbTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
