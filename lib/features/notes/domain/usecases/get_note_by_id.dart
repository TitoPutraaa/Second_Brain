import 'package:second_brain/features/notes/domain/entities/note.dart';
import 'package:second_brain/features/notes/domain/repositories/note_repo.dart';

class GetNoteById {
  final NoteRepo noteRepo;

  GetNoteById(this.noteRepo);

  Future<Note> execute(int id) async {
    if (id.isNegative) {
      throw Exception("can't found negative id");
    }
    return await noteRepo.getNoteById(id);
  }
}
