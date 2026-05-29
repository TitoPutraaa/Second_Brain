import 'package:second_brain/features/notes/domain/entities/kategori.dart';
import 'package:second_brain/features/notes/domain/entities/note.dart';

abstract class NoteRepo {
  Future<List<Note>> getAllNote();
  Future<void> saveNote(Note note);
  Future<Note> getNoteById(int idNote);
  Future<void> deleteNote(int id);
  Future<void> updateNote(Note note);
  Future<void> addKategori(Kategori kategori);
  Future<List<Note>> getFavoriteNote(int getFavorite);
  Future<List<Note>> getNoteByKategori(int kategori);
}
