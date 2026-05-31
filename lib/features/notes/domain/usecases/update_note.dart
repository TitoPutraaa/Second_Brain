import 'package:second_brain/features/notes/domain/repositories/note_repo.dart';

class UpdateNote {
  final NoteRepo noteRepo;

  UpdateNote(this.noteRepo);

  Future<void> execute({
    required int idNote,
    int? idKategori,
    String? title,
    String? content,
    int? isFavorite,
    int? isDelete,
  }) async {
    final existingNote = await noteRepo.getNoteById(idNote);
    final updateNote = existingNote.copyWith(
      title: title?.trim(),
      content: content?.trim(),
      isFavorite: isFavorite,
      isDeleted: isDelete,
      idKategori: idKategori,
    );
    return await noteRepo.updateNote(updateNote);
  }
}
