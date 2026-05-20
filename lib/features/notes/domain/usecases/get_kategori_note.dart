import 'package:second_brain/features/notes/domain/entities/kategori.dart';
import 'package:second_brain/features/notes/domain/repositories/note_repo.dart';

class GetKategoriNote {
  final NoteRepo noteRepo;

  GetKategoriNote(this.noteRepo);

  Future<List<Kategori>> execute(String kategori) async {
    return await noteRepo.getKategoriNote(kategori);
  }
}
