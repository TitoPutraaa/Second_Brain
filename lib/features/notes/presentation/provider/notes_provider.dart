import 'package:flutter/cupertino.dart';
import 'package:second_brain/features/notes/domain/entities/note.dart';
import 'package:second_brain/features/notes/domain/usecases/add_kategori.dart';
import 'package:second_brain/features/notes/domain/usecases/delete_note.dart';
import 'package:second_brain/features/notes/domain/usecases/get_all_note.dart';
import 'package:second_brain/features/notes/domain/usecases/get_favorite_note.dart';
import 'package:second_brain/features/notes/domain/usecases/get_note_by_id.dart';
import 'package:second_brain/features/notes/domain/usecases/get_note_by_kategori.dart';
import 'package:second_brain/features/notes/domain/usecases/save_note.dart';
import 'package:second_brain/features/notes/domain/usecases/update_note.dart';

enum NotesStatus { initial, loading, success, error }

class NotesProvider with ChangeNotifier {
  final GetAllNote getAllNote;
  final SaveNote saveNote;
  final DeleteNote deleteNote;
  final UpdateNote updateNote;
  final AddKategori addKategori;
  final GetFavoriteNote getFavoriteNote;
  final GetNoteByKategori getNoteByKategori;

  NotesProvider({
    required this.getAllNote,
    required this.saveNote,
    required this.deleteNote,
    required this.updateNote,
    required this.addKategori,
    required this.getFavoriteNote,
    required this.getNoteByKategori,
  });

  NotesStatus status = NotesStatus.initial;
  String errorMessage = "";
  List<Note> notes = [];

  Future<void> getAllNotes() async {
    status = NotesStatus.loading;
    notifyListeners();

    try {
      notes = await getAllNote.execute();
      status = NotesStatus.success;
      errorMessage = "";
    } catch (e) {
      status = NotesStatus.error;
      errorMessage = "Failed to get all notes. Errors : ${e.toString()}";
      notifyListeners();
    }

    notifyListeners();
  }

  Future<void> saveNewNote({
    required String title,
    required String content,
  }) async {
    status = NotesStatus.loading;
    notifyListeners();

    try {
      await saveNote.execute(title: title, content: content);
      status = NotesStatus.success;
      errorMessage = "";
      await getAllNotes();
      return;
    } catch (e) {
      status = NotesStatus.error;
      errorMessage = "Failed to save new note. Errors : ${e.toString()}";
    }
    notifyListeners();
  }
}
