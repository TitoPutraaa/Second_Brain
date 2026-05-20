import 'package:second_brain/features/notes/domain/entities/note.dart';
import 'package:second_brain/features/notes/domain/repositories/note_repo.dart';

class GetFavoritNote {
  final NoteRepo noteRepo;

  GetFavoritNote(this.noteRepo);

  Future<List<Note>> execute() async {
    return await noteRepo.getFavoriteNote();
  }
}
