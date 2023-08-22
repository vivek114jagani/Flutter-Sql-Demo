import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // create a name constructor.
  DatabaseHelper._privateConstructor();
  // create a object class
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Database Object
  static Database? _database;

  //Create a new database
  Future<Database> _initDatabase() async {
    //get the path of the database
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "demo.db");

    log(path);

    // crete database and table
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE Users (id INTEGER AUTO INCREMENT PRIMARY KEY,firstname TEXT,lastname TEXT,email TEXT)");
      },
    );
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    print(_database?.path);
    // print(_database);
    print(_database?.isOpen);
    return _database!;
  }

  Future<int?> insertData(String fname, String lname, String email) async {
    return await _database?.insert(
      'Users',
      {"firstname": fname, "lastname": lname, "email": email},
    );
  }

  Future<List<Map<String, Object?>>?> getData() async {
    return await _database?.query("Users");
  }

  Future<int?> deleterecord(String id) async {
    return await _database?.delete("Users", where: "id = ?", whereArgs: [id]);
  }

  Future<int?> updateRecord(String fname, String lname, String email,
      {required String id}) async {
    return await _database?.update(
      "Users",
      {
        "firstname": fname,
        "lastname": lname,
        "email": email,
      },
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int?> deleteTable() async {
    return await _database?.delete("Users");
  }
}
