import 'package:second_brain/features/notes/domain/repositories/note_repo.dart';

class DeleteNote {
  final NoteRepo noteRepo;

  DeleteNote(this.noteRepo);

  Future execute(int id) async {
    return await noteRepo.deleteNote(id);
  }
}
