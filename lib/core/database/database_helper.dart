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
    return openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('PRAGMA foreign_keys = ON');

    await db.execute('''
    CREATE TABLE notes (
      id_note TEXT AUTO_INCREMENT PRIMARY KEY,
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
      id_kategori TEXT AUTO_INCREMENT PRIMARY KEY,
      id_note TEXT,
      FOREIGN KEY (id_note) REFERENCES notes (id_note)
      );
    ''');
  }
}
