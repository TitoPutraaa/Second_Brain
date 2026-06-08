import 'package:second_brain/features/notes/domain/entities/kategori.dart';
import 'package:second_brain/features/notes/domain/repositories/note_repo.dart';

class GetAllKategori {
  final NoteRepo noteRepo;

  GetAllKategori(this.noteRepo);

  Future<List<Kategori>> execute() async {
    return await noteRepo.getAllKategori();
  }
}
