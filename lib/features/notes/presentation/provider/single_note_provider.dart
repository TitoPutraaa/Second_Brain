import 'package:flutter/foundation.dart';
import 'package:second_brain/features/notes/domain/entities/note.dart';
import 'package:second_brain/features/notes/domain/usecases/get_note_by_id.dart';

enum SingleNoteStatus { initial, loading, success, error }

class SingleNoteProvider with ChangeNotifier {
  final GetNoteById getNoteById;

  SingleNoteProvider({required this.getNoteById});

  SingleNoteStatus status = SingleNoteStatus.initial;
  String errorMessage = "";
  Note? note;

  Future<void> getNoteByIdProvider(int id) async {
    status = SingleNoteStatus.loading;
    notifyListeners();

    try {
      note = await getNoteById.execute(id);
      status = SingleNoteStatus.success;
      errorMessage = "";
    } catch (e) {
      status = SingleNoteStatus.error;
      errorMessage = "can't find note ${e.toString()}";
      notifyListeners();
    }
    notifyListeners();
  }
}
