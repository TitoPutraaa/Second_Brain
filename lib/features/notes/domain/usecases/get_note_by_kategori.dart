import 'package:second_brain/features/notes/domain/entities/note.dart';
import 'package:second_brain/features/notes/domain/repositories/note_repo.dart';

class GetNoteByKategori {
  final NoteRepo noteRepo;

  GetNoteByKategori({required this.noteRepo});

  Future<List<Note>> execute(int kategori) async {
    return await noteRepo.getNoteByKategori(kategori);
  }
}
