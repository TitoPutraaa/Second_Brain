import 'package:second_brain/features/notes/domain/entities/kategori.dart';
import 'package:second_brain/features/notes/domain/repositories/note_repo.dart';

class AddKategori {
  final NoteRepo noteRepo;

  AddKategori(this.noteRepo);

  Future<void> execute({required String kategoriName}) async {
    if (kategoriName.isEmpty) {
      throw Exception("kategori name can't be empty");
    }
    final newKategori = Kategori(kategoriName: kategoriName);

    return await noteRepo.addKategori(newKategori);
  }
}
