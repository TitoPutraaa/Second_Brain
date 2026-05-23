import 'package:second_brain/features/notes/domain/repositories/note_repo.dart';

class SaveNote {
  final NoteRepo noteRepo;
  SaveNote(this.noteRepo);

  Future<void> execute() async {
    return await noteRepo.saveNote(note);
  }
}
