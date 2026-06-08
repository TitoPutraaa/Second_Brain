import 'package:second_brain/features/notes/domain/entities/note.dart';
import 'package:second_brain/features/notes/domain/repositories/note_repo.dart';

class SaveNote {
  final NoteRepo noteRepo;
  SaveNote(this.noteRepo);

  Future<void> execute({
    required String title,
    required String content,
    int? idKategori,
    int isFavorite = 0,
  }) async {
    if (content.trim().isEmpty) {
      throw Exception("note content cannot empty");
    }

    final note = Note(
      title: title.trim(),
      content: content.trim(),
      idKategori: idKategori,
      isFavorite: isFavorite,
    );
    await noteRepo.saveNote(note);
  }
}
