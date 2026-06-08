import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_brain/features/notes/domain/entities/kategori.dart';
import 'package:second_brain/features/notes/presentation/pages/note_page.dart';
import 'package:second_brain/features/notes/presentation/provider/notes_provider.dart';
import 'package:second_brain/features/notes/presentation/widgets/note_card.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotesProvider>().getFavoriteNotesProvider(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotesProvider>();

    switch (provider.status) {
      case NotesStatus.loading:
        return Center(child: CircularProgressIndicator());

      case NotesStatus.error:
        return Center(child: Text(provider.errorMessage));

      case NotesStatus.success:
        if (provider.notes.isEmpty) {
          return Center(child: Text("No favorite notes yet"));
        }
        return Scaffold(
          body: GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3.5 / 4,
              crossAxisSpacing: 5,
              mainAxisSpacing: 3,
            ),
            itemCount: provider.notes.length,
            itemBuilder: (context, index) {
              final note = provider.notes[index];
              final kategori = provider.categories.cast<Kategori>().firstWhere(
                (cat) => cat.idKategori == note.idKategori,
                orElse: () => const Kategori(kategoriName: ""),
              );
              return NoteCard(
                key: ValueKey(note.idNote),
                note: note,
                kategoriName:
                    kategori.kategoriName.isEmpty
                        ? null
                        : kategori.kategoriName,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotePage(note: note),
                    ),
                  );
                },
              );
            },
          ),
        );

      default:
        return Center(child: Text("Initializing..."));
    }
  }
}
