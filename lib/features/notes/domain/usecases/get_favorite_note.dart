import 'package:second_brain/features/notes/domain/entities/note.dart';
import 'package:second_brain/features/notes/domain/repositories/note_repo.dart';

class GetFavoriteNote {
  final NoteRepo noteRepo;

  GetFavoriteNote(this.noteRepo);

  Future<List<Note>> execute(int idKategori) async {
    if (idKategori.isNegative) {
      throw Exception("id kategori can't be null");
    }
    return await noteRepo.getFavoriteNote(idKategori);
  }
}
