import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_brain/core/di/get_it.dart';
import 'package:second_brain/core/ui/main_sheet.dart';
import 'package:second_brain/features/notes/presentation/provider/notes_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: .fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
        ),
        home: MainSheet(),
      ),
      create: (context) => getIt<NotesProvider>()..getAllNotes(),
    );
  }
}
