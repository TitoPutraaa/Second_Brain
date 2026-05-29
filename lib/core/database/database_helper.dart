import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbDirPath = await getDatabasesPath();
    final path = join(dbDirPath, 'second_brain.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onConfigure: _onConfigure,
    );
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE kategori (
      idKategori INTEGER PRIMARY KEY AUTOINCREMENT,
      kategoriName TEXT NOT NULL
      );
    ''');

    await db.execute('''
    CREATE TABLE notes (
      idNote INTEGER PRIMARY KEY AUTOINCREMENT,
      idKategori INTEGER,
      title TEXT,
      content TEXT,
      isFavorite INTEGER DEFAULT 0,
      isDeleted INTEGER DEFAULT 0,
      FOREIGN KEY (idKategori) REFERENCES kategori (idKategori)
      );
    ''');
  }
}
