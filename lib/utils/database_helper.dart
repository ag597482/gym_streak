import 'package:gym_streak/models/exersise.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper; // Singleton DatabaseHelper
  static Database? _database; // Singleton Database

  String exersiseTable = 'exersise_table';
  String colId = 'id';
  String colTitle = 'title';
  String colMuscle = 'muscle';
  String colLasteWorkoutDate = 'lastWorkoutDate';
  String colCount = 'count';
  String colSet1Avg = 'set1Avg';
  String colSet2Avg = 'set2Avg';
  String colSet3Avg = 'set3Avg';
  String colSet1High = 'set1High';
  String colSet2High = 'set2High';
  String colSet3High = 'set3High';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}exersises.db';

    // Open/create the database at a given path
    var exersisesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return exersisesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $exersiseTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
        '$colMuscle TEXT, $colCount INTEGER, $colSet1Avg INTEGER, $colSet2Avg INTEGER, $colSet3Avg INTEGER, $colSet1High INTEGER, $colSet2High INTEGER, $colSet3High INTEGER, $colLasteWorkoutDate TEXT)');
  }

  // Fetch Operation: Get all exersises objects from database
  Future<List<Map<String, dynamic>>> getExersiseMapList(muscle) async {
    Database db = await database;

//		var result = await db.rawQuery('SELECT * FROM $exersiseTable order by $colPriority ASC');
// , orderBy: '$colPriority ASC'
    var result = await db
        .query(exersiseTable, where: '$colMuscle = ?', whereArgs: [muscle]);
    return result;
  }

  // Insert Operation: Insert a Exersise object to database
  Future<int> insertExersise(Exersise exersise) async {
    Database db = await database;
    var result = await db.insert(exersiseTable, exersise.toMap());
    return result;
  }

  // Update Operation: Update a Exersise object and save it to database
  Future<int> updateExersise(Exersise exersise) async {
    var db = await database;
    var result = await db.update(exersiseTable, exersise.toMap(),
        where: '$colId = ?', whereArgs: [exersise.id]);
    return result;
  }

  // Delete Operation: Delete a Exersise object from database
  Future<int> deleteExersise(int? id) async {
    var db = await database;
    int result =
        await db.rawDelete('DELETE FROM $exersiseTable WHERE $colId = $id');
    return result;
  }

  // Get number of Exersise objects in database
  Future<int> getCount() async {
    Database db = await database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $exersiseTable');
    int result = Sqflite.firstIntValue(x)!;
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Exersise List' [ List<Exersise> ]
  Future<List<Exersise>> getExersiseList(muscle) async {
    var exersiseMapList =
        await getExersiseMapList(muscle); // Get 'Map List' from database
    int count =
        exersiseMapList.length; // Count the number of map entries in db table

    List<Exersise> exersiseList = <Exersise>[];
    // For loop to create a 'Exersise List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      exersiseList.add(Exersise.fromMapObject(exersiseMapList[i]));
    }
    return exersiseList;
  }
}
