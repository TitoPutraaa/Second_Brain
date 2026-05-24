import 'package:second_brain/core/database/database_helper.dart';
import 'package:second_brain/features/notes/data/models/note_model.dart';
import 'package:sqflite/sqflite.dart';

class NoteDataSource {
  final DatabaseHelper dbHelper;

  NoteDataSource({required this.dbHelper});

  Future<List<NoteModel>> getAllNote() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('notes');

    return maps.map((row) => NoteModel.fromMap(row)).toList();
  }

  Future<void> saveNote(NoteModel note) async {
    final db = await dbHelper.database;
    await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.rollback,
    );
  }
}
