import 'package:get_it/get_it.dart';
import 'package:second_brain/core/database/database_helper.dart';
import 'package:second_brain/features/notes/data/datasources/note_data_source.dart';
import 'package:second_brain/features/notes/data/repositories/note_repo_impl.dart';
import 'package:second_brain/features/notes/domain/repositories/note_repo.dart';
import 'package:second_brain/features/notes/domain/usecases/add_kategori.dart';
import 'package:second_brain/features/notes/domain/usecases/delete_note.dart';
import 'package:second_brain/features/notes/domain/usecases/get_all_kategori.dart';
import 'package:second_brain/features/notes/domain/usecases/get_all_note.dart';
import 'package:second_brain/features/notes/domain/usecases/get_favorite_note.dart';
import 'package:second_brain/features/notes/domain/usecases/get_note_by_id.dart';
import 'package:second_brain/features/notes/domain/usecases/get_note_by_kategori.dart';
import 'package:second_brain/features/notes/domain/usecases/save_note.dart';
import 'package:second_brain/features/notes/domain/usecases/update_note.dart';
import 'package:second_brain/features/notes/presentation/provider/notes_provider.dart';
import 'package:second_brain/features/notes/presentation/provider/single_note_provider.dart';

final getIt = GetIt.instance;

Future setup() async {
  registerDatabase();
  registerDataSource();
  registerRepository();
  registerUseCase();
  registerProvider();
}

void registerDatabase() {
  getIt.registerSingleton<DatabaseHelper>(DatabaseHelper());
}

void registerDataSource() {
  getIt.registerSingleton(NoteDataSource(dbHelper: getIt()));
}

void registerRepository() {
  getIt.registerSingleton<NoteRepo>(NoteRepoImpl(localDataSource: getIt()));
}

void registerUseCase() {
  getIt.registerSingleton(GetAllNote(getIt()));
  getIt.registerSingleton(SaveNote(getIt()));
  getIt.registerSingleton(DeleteNote(getIt()));
  getIt.registerSingleton(UpdateNote(getIt()));
  getIt.registerSingleton(AddKategori(getIt()));
  getIt.registerSingleton(GetAllKategori(getIt()));
  getIt.registerSingleton(GetFavoriteNote(getIt()));
  getIt.registerSingleton(GetNoteByKategori(getIt()));
  getIt.registerSingleton(GetNoteById(getIt()));
}

void registerProvider() {
  getIt.registerFactory<NotesProvider>(
    () => NotesProvider(
      getAllNote: getIt<GetAllNote>(),
      saveNote: getIt<SaveNote>(),
      deleteNote: getIt<DeleteNote>(),
      updateNote: getIt<UpdateNote>(),
      addKategori: getIt<AddKategori>(),
      getAllKategori: getIt<GetAllKategori>(),
      getFavoriteNote: getIt<GetFavoriteNote>(),
      getNoteByKategori: getIt<GetNoteByKategori>(),
    ),
  );
  getIt.registerFactory<SingleNoteProvider>(
    () => SingleNoteProvider(getNoteById: getIt<GetNoteById>()),
  );
}
