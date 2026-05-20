import 'package:second_brain/features/notes/domain/entities/note.dart';
import 'package:second_brain/features/notes/domain/repositories/note_repo.dart';

class GetAllNote {
  final NoteRepo noteRepo;

  GetAllNote(this.noteRepo);

  Future<List<Note>> execute() async {
    return await noteRepo.getAllNote();
  }
}
