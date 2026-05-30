import 'package:second_brain/features/notes/data/datasources/note_data_source.dart';
import 'package:second_brain/features/notes/data/models/kategori_model.dart';
import 'package:second_brain/features/notes/data/models/note_model.dart';
import 'package:second_brain/features/notes/domain/entities/kategori.dart';
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
      title: note.title,
      isFavorite: note.isFavorite,
      isDeleted: note.isDeleted,
    );
    await localDataSource.saveNote(noteModel);
  }

  @override
  Future<void> addKategori(Kategori kategori) async {
    final kategorimodel = KategoriModel(kategoriName: kategori.kategoriName);
    return await localDataSource.addKategori(kategorimodel);
  }

  @override
  Future<void> deleteNote(int id) async {
    await localDataSource.deleteNote(id);
  }

  @override
  Future<List<Note>> getFavoriteNote(int getFavorite) async {
    return await localDataSource.getFavoriteNote(getFavorite);
  }

  @override
  Future<Note> getNoteById(int idNote) async {
    return await localDataSource.getNotebyId(idNote);
  }

  @override
  Future<List<Note>> getNoteByKategori(int kategori) async {
    return await localDataSource.getNoteByKategori(kategori);
  }

  @override
  Future<void> updateNote(Note note) async {
    final upd = NoteModel(
      idNote: note.idNote,
      idKategori: note.idKategori,
      content: note.content,
      title: note.title,
      isFavorite: note.isFavorite,
      isDeleted: note.isDeleted,
    );
    await localDataSource.updateNote(upd);
  }
}
