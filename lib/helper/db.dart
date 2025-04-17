import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  //A static instance of DatabaseHelper, ensuring only one database connection exists.
  static final DatabaseHelper instance = DatabaseHelper._init();
  // A private variable to store the database instance.
  static Database? _database;

  //A private constructor to prevent external instantiation.
  DatabaseHelper._init();

  //get the database instance
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB('user_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit(); // Initialize ffi for desktop platforms
      databaseFactory = databaseFactoryFfi;
    }

    //Get the path for storing the database file.
    final dbPath = await getDatabasesPath();
    //join the database path with the file name
    final path = join(dbPath, filePath);
    return await databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
      version: 1,
      onCreate: _createDB, //call _createDB if the DB doesn't exist
    ));
  }
Future<void> _createDB(Database db, int version) async {
  await db.execute('''
    CREATE TABLE Stores(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      isFavorite INTEGER DEFAULT 0
    )
  ''');
}
// Insert a store
Future<int> insertStore(Map<String, dynamic> store) async {
  final db = await instance.database;
  return await db.insert('Stores', store);
}

// Get all stores
Future<List<Map<String, dynamic>>> getAllStores() async {
  final db = await instance.database;
  return await db.query('Stores');
}

// Get favorite stores
Future<List<Map<String, dynamic>>> getFavoriteStores() async {
  final db = await instance.database;
  return await db.query('Stores', where: 'isFavorite = ?', whereArgs: [1]);
}

// Future<List<Map<String, dynamic>>> getNonFavoriteStores() async {
//   final db = await instance.database;
//   return await db.query('Stores', where: 'isFavorite = ?', whereArgs: [0]);
// }
// Fetch stores with isFavorite = 0 (non-favorite stores)

Future<List<Map<String, dynamic>>> getStoresWithFavoriteStatus({required int isFavorite}) async {
  final db = await instance.database;
  return await db.query(
    'Stores',
    where: 'isFavorite = ?',
    whereArgs: [isFavorite],
  );
}

// Toggle favorite status of a store
Future<void> toggleFavorite(int id, bool isFavorite) async {
  final db = await instance.database;
  await db.update(
    'Stores',
    {'isFavorite': isFavorite ? 1 : 0},
    where: 'id = ?',
    whereArgs: [id],
  );
}
}
