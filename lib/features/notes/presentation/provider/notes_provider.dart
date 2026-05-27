import 'package:flutter/cupertino.dart';
import 'package:second_brain/features/notes/domain/entities/note.dart';
import 'package:second_brain/features/notes/domain/usecases/get_all_note.dart';
import 'package:second_brain/features/notes/domain/usecases/save_note.dart';

enum NotesStatus { initial, loading, success, error }

class NotesProvider with ChangeNotifier {
  final GetAllNote getAllNote;
  final SaveNote saveNote;

  NotesProvider({required this.getAllNote, required this.saveNote});

  NotesStatus status = NotesStatus.initial;
  String errorMessage = "";

  void getAllNotes() async {
    status = NotesStatus.loading;
    notifyListeners();

    try {
      await getAllNote.execute();
    } catch (e) {
      status = NotesStatus.error;
      errorMessage = "Failed to get all notes. Errors : ${e.toString()}";
      notifyListeners();
    } finally {
      status = NotesStatus.success;
      errorMessage = "";
      notifyListeners();
    }
  }

  void saveNewNote(Note note) async {
    status = NotesStatus.loading;
    notifyListeners();

    try {
      await saveNote.execute(note);
    } catch (e) {
      status = NotesStatus.error;
      errorMessage = "Failed to save new note. Errors : ${e.toString()}";
      notifyListeners();
    } finally {
      status = NotesStatus.success;
      errorMessage = "";
      notifyListeners();
    }
  }
}
