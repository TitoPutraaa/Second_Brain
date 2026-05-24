import 'package:second_brain/features/notes/domain/entities/note.dart';
import 'package:second_brain/features/notes/domain/repositories/note_repo.dart';

class SaveNote {
  final NoteRepo noteRepo;
  SaveNote(this.noteRepo);

  Future<void> execute(Note note) async {
    return await noteRepo.saveNote(note);
  }
}
