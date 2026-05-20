import 'package:second_brain/features/notes/domain/entities/kategori.dart';
import 'package:second_brain/features/notes/domain/entities/note.dart';

abstract class NoteRepo {
  Future<List<Note>> getAllNote();
  Future<List<Note>> getFavoriteNote();
  Future<List<Kategori>> getKategoriNote(String kategori);
}
