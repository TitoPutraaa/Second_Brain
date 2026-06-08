import 'package:flutter/cupertino.dart';
import 'package:second_brain/features/notes/domain/entities/kategori.dart';
import 'package:second_brain/features/notes/domain/entities/note.dart';
import 'package:second_brain/features/notes/domain/usecases/add_kategori.dart';
import 'package:second_brain/features/notes/domain/usecases/delete_note.dart';
import 'package:second_brain/features/notes/domain/usecases/get_all_kategori.dart';
import 'package:second_brain/features/notes/domain/usecases/get_all_note.dart';
import 'package:second_brain/features/notes/domain/usecases/get_favorite_note.dart';
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
  final GetAllKategori getAllKategori;
  final GetFavoriteNote getFavoriteNote;
  final GetNoteByKategori getNoteByKategori;

  NotesProvider({
    required this.getAllNote,
    required this.saveNote,
    required this.deleteNote,
    required this.updateNote,
    required this.addKategori,
    required this.getAllKategori,
    required this.getFavoriteNote,
    required this.getNoteByKategori,
  });

  NotesStatus status = NotesStatus.initial;
  String errorMessage = "";
  List<Note> notes = [];
  List<Kategori> categories = [];

  Future<void> getAllNotes() async {
    status = NotesStatus.loading;
    notifyListeners();

    try {
      notes = await getAllNote.execute();
      await fetchCategories();
      status = NotesStatus.success;
      errorMessage = "";
    } catch (e) {
      status = NotesStatus.error;
      errorMessage = "Failed to get all notes. Errors : ${e.toString()}";
      notifyListeners();
    }

    notifyListeners();
  }

  Future<void> fetchCategories() async {
    try {
      categories = await getAllKategori.execute();
    } catch (e) {
      errorMessage = "Failed to fetch categories. Errors : ${e.toString()}";
    }
  }

  Future<void> saveNewNote({
    required String title,
    required String content,
    int? idKategori,
    int isFavorite = 0,
  }) async {
    status = NotesStatus.loading;
    notifyListeners();

    try {
      await saveNote.execute(
        title: title,
        content: content,
        idKategori: idKategori,
        isFavorite: isFavorite,
      );
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

  Future<void> deleteNoteProvider(int id) async {
    status = NotesStatus.loading;
    notifyListeners();

    try {
      await deleteNote.execute(id);
      status = NotesStatus.success;
      errorMessage = "";
      await getAllNotes();
      return;
    } catch (e) {
      status = NotesStatus.error;
      errorMessage = "Failed to delete note. Errors : ${e.toString()}";
    }
    notifyListeners();
  }

  Future<void> updateNoteProvider(Note note) async {
    status = NotesStatus.loading;
    notifyListeners();

    try {
      await updateNote.execute(
        idNote: note.idNote!,
        title: note.title,
        content: note.content,
        isFavorite: note.isFavorite,
        idKategori: note.idKategori,
        isDelete: note.isDeleted,
      );
      status = NotesStatus.success;
      errorMessage = "";
      await getAllNotes();
      return;
    } catch (e) {
      status = NotesStatus.error;
      errorMessage = "Failed to update note. Errors : ${e.toString()}";
    }
    notifyListeners();
  }

  Future<void> addKategoriProvider(String kategoriName) async {
    status = NotesStatus.loading;
    notifyListeners();

    try {
      await addKategori.execute(kategoriName: kategoriName);
      status = NotesStatus.success;
      errorMessage = "";
      await fetchCategories();
    } catch (e) {
      status = NotesStatus.error;
      errorMessage = "Failed to add kategori. Errors : ${e.toString()}";
    }
    notifyListeners();
  }

  Future<void> getFavoriteNotesProvider(int isFavorite) async {
    status = NotesStatus.loading;
    notifyListeners();

    try {
      notes = await getFavoriteNote.execute(isFavorite);
      status = NotesStatus.success;
      errorMessage = "";
    } catch (e) {
      status = NotesStatus.error;
      errorMessage = "Failed to get favorite notes. Errors : ${e.toString()}";
    }
    notifyListeners();
  }

  Future<void> getNotesByCategoryProvider(int idKategori) async {
    status = NotesStatus.loading;
    notifyListeners();

    try {
      notes = await getNoteByKategori.execute(idKategori);
      status = NotesStatus.success;
      errorMessage = "";
    } catch (e) {
      status = NotesStatus.error;
      errorMessage =
          "Failed to get notes by kategori. Errors : ${e.toString()}";
    }
    notifyListeners();
  }
}
