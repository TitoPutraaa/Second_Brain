import 'package:second_brain/core/database/database_helper.dart';
import 'package:second_brain/features/notes/data/models/note_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class NoteDataSource {
  Future<void> cacheNote(NoteModel note);
  Future<List<NoteModel>> getCachedNote();
}

class NoteDataSourceImpl implements NoteDataSource {
  final DatabaseHelper dbHelper;

  NoteDataSourceImpl({required this.dbHelper});

  @override
  Future<void> cacheNote(NoteModel note) async {
    final db = await dbHelper.database;
    await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<NoteModel>> getCachedNote() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('notes');

    return maps.map((row) => NoteModel.fromMap(row)).toList();
  }
}
