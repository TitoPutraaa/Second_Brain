import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_brain/features/notes/domain/entities/kategori.dart';
import 'package:second_brain/features/notes/presentation/pages/note_page.dart';
import 'package:second_brain/features/notes/presentation/provider/notes_provider.dart';
import 'package:second_brain/features/notes/presentation/widgets/kategori_btn.dart';
import 'package:second_brain/features/notes/presentation/widgets/note_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotesProvider>();
    switch (provider.status) {
      case NotesStatus.loading:
        return Center(child: CircularProgressIndicator());

      case NotesStatus.error:
        return Center(child: Text("$provider.errorMessage"));

      case NotesStatus.success:
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: KategoriBtn()),
              if (provider.notes.isEmpty)
                const SliverFillRemaining(
                  child: Center(child: Text("No notes yet. Tap + to add one!")),
                )
              else
                SliverGrid.builder(
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
            ],
          ),
        );

      default:
        return Center(child: Center(child: Text("lahh gaa status nya manee")));
    }
  }
}
