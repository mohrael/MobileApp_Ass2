import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLDB {
  static Database? _db;
  final int _dbVersion = 1;

  Future<Database?> get db async {
    if (_db != null && _db!.isOpen) {
      return _db;
    }
    _db = await initializeDB();
    return _db;
  }

  Future<Database> initializeDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "mainDatabase.db");
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE Students (
        "StudentId" INTEGER PRIMARY KEY, 
        "Name" TEXT NOT NULL, 
        "Email" TEXT UNIQUE NOT NULL, 
        "Password" TEXT NOT NULL, 
        "Level" INTEGER, 
        "Gender" TEXT,
        "PicturePath" TEXT
      )
    """);
  }

  Future<List<Map<String, dynamic>>> getAllStudents() async {
    Database? mydb = await db;
    return await mydb!.rawQuery("SELECT * FROM 'Students'");
  }

  Future<Map<String, dynamic>?> getStudentById(int studentId) async {
    Database? mydb = await db;
    List<Map<String, dynamic>> result = await mydb!.rawQuery(
      'SELECT * FROM Students WHERE StudentId = ?',
      [studentId],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<int> insertStudent(String name, String email, int studentId,
      String password, int? level, String? gender) async {
    Database? mydb = await db;

    // Check if StudentId exists
    List<Map<String, dynamic>> existingStudent = await mydb!.rawQuery(
      'SELECT * FROM Students WHERE StudentId = ?',
      [studentId],
    );

    if (existingStudent.isNotEmpty) {
      // print("Error: Student ID already exists!");
      return -1;
    } else {
      // Insert new student
      return await mydb.rawInsert(
        'INSERT INTO Students (StudentId, Name, Email, Password, Level, Gender) VALUES (?, ?, ?, ?, ?, ?)',
        [studentId, name, email, password, level, gender],
      );
    }
  }

  Future<int> updateStudent(
    int studentId, {
    String? name,
    String? email,
    String? password,
    int? level,
    String? gender,
    String? picturePath,
  }) async {
    Database? mydb = await db;

    // Check if student exists
    List<Map<String, dynamic>> existingStudent = await mydb!.rawQuery(
      'SELECT * FROM Students WHERE StudentId = ?',
      [studentId],
    );

    if (existingStudent.isEmpty) {
      return -1; // Student not found
    }

    return await mydb.rawUpdate(
      'UPDATE Students SET Name = COALESCE(?, Name), Email = COALESCE(?, Email), Password = COALESCE(?, Password), Level = COALESCE(?, Level), Gender = COALESCE(?, Gender), PicturePath = COALESCE(?, PicturePath) WHERE StudentId = ?',
      [name, email, password, level, gender, picturePath, studentId],
    );
  }
}
