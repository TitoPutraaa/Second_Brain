import 'package:get_it/get_it.dart';
import 'package:second_brain/core/database/database_helper.dart';
import 'package:second_brain/features/notes/data/datasources/note_data_source.dart';
import 'package:second_brain/features/notes/data/repositories/note_repo_impl.dart';
import 'package:second_brain/features/notes/domain/repositories/note_repo.dart';
import 'package:second_brain/features/notes/domain/usecases/get_all_note.dart';
import 'package:second_brain/features/notes/domain/usecases/save_note.dart';
import 'package:second_brain/features/notes/presentation/provider/notes_provider.dart';

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
}

void registerProvider() {
  getIt.registerFactory<NotesProvider>(
    () => NotesProvider(
      getAllNote: getIt<GetAllNote>(),
      saveNote: getIt<SaveNote>(),
    ),
  );
}
