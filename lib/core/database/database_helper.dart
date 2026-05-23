import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('second_brain.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbDirPath = await getDatabasesPath();
    final path = join(dbDirPath, filePath);
    return openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('PRAGMA foreign_keys = ON');

    await db.execute('''
    CREATE TABLE notes (
      id_note TEXT PRIMARY KEY,
      id_kategori TEXT,
      title TEXT NOT NULL,
      content TEXT,
      is_favorite NOT NULL DEFAULT 0,
      is_deleted NOT NULL DEFAULT 0,
      FOREIGN KEY (id_kategori) REFERENCES kategori (id_kategori)
      );
    ''');

    await db.execute('''
    CREATE TABLE kategori (
      id_kategori TEXT PRIMARY KEY,
      id_note TEXT,
      FOREIGN KEY (id_note) REFERENCES notes (id_note)
      );
    ''');
  }
}
