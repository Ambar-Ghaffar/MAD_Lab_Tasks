import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_task/student.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initializeDatabase();
    return _database!;
  }
   Future<int> insertStudent(Student student) async {
    final db = await database;
    return await db.insert('students', student.toMap());
  }

  Future<int> updateStudent(Student student) async {
    final db = await database;
    return await db.update('students', student.toMap(),
        where: 'id = ?', whereArgs: [student.id]);
  }

  Future<int> deleteStudent(int id) async {
    final db = await database;
    return await db.delete('students', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Student>> getAllStudents() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('students');
    return List.generate(maps.length, (i) {
      return Student(
        id: maps[i]['id'],
        name: maps[i]['name'],
        grade: maps[i]['grade'],
      );
    });
  }

  Future<List<Student>> searchStudents(String query) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('students', where: 'name LIKE ?', whereArgs: ['%$query%']);
    return List.generate(maps.length, (i) {
      return Student(
        id: maps[i]['id'],
        name: maps[i]['name'],
        grade: maps[i]['grade'],
      );
    });
  }

  Future<Database> initializeDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'student_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute("CREATE TABLE students (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT, grade TEXT)");
      },
    );

    
  }
}
