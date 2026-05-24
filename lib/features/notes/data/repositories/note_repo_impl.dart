import 'package:second_brain/features/notes/data/datasources/note_data_source.dart';
import 'package:second_brain/features/notes/data/models/note_model.dart';
import 'package:second_brain/features/notes/domain/entities/note.dart';
import 'package:second_brain/features/notes/domain/repositories/note_repo.dart';

class NoteRepoImpl implements NoteRepo {
  final NoteDataSource localDataSource;

  NoteRepoImpl({required this.localDataSource});

  @override
  Future<List<Note>> getAllNote() async {
    return await localDataSource.getAllNote();
  }

  @override
  Future<void> saveNote(Note note) async {
    final noteModel = NoteModel(
      idNote: note.idNote,
      idKategori: note.idKategori,
      content: note.content,
      judul: note.judul,
      isFavorite: note.isFavorite,
      isDeleted: note.isDeleted,
    );
    await localDataSource.saveNote(noteModel);
  }
}
