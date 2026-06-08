import 'package:second_brain/core/database/database_helper.dart';
import 'package:second_brain/features/notes/data/models/kategori_model.dart';
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

  Future<NoteModel> getNotebyId(int idNote) async {
    final db = await dbHelper.database;
    var maps = await db.query(
      'notes',
      where: "idNote = ?",
      whereArgs: [idNote],
      limit: 1,
    );
    return NoteModel.fromMap(maps.first);
  }

  Future<void> deleteNote(int id) async {
    final db = await dbHelper.database;
    await db.delete("notes", where: "idNote = ?", whereArgs: [id]);
  }

  Future<void> updateNote(NoteModel note) async {
    final db = await dbHelper.database;
    await db.update(
      "notes",
      note.toMap(),
      where: "idNote = ?",
      whereArgs: [note.idNote],
    );
  }

  Future<void> addKategori(KategoriModel kategori) async {
    final db = await dbHelper.database;
    await db.insert(
      "kategori",
      kategori.toMap(),
      conflictAlgorithm: ConflictAlgorithm.rollback,
    );
  }

  Future<List<NoteModel>> getFavoriteNote(int getFavorite) async {
    final db = await dbHelper.database;
    var fetch = await db.query(
      "notes",
      where: "isFavorite = ?",
      whereArgs: [getFavorite],
    );
    return fetch.map((rows) => NoteModel.fromMap(rows)).toList();
  }

  Future<List<NoteModel>> getNoteByKategori(int kategori) async {
    final db = await dbHelper.database;
    var fetch = await db.query(
      "notes",
      where: "idKategori = ?",
      whereArgs: [kategori],
    );

    return fetch.map((rows) => NoteModel.fromMap(rows)).toList();
  }

  Future<List<KategoriModel>> getAllKategori() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('kategori');

    return maps.map((row) => KategoriModel.fromMap(row)).toList();
  }
}
