import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
              SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3.5 / 4,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 3,
                ),
                itemCount: provider.notes.length,
                itemBuilder: (context, index) => NoteCard(
                  key: ValueKey(provider.notes[index].idNote),
                  title: provider.notes[index].title!,
                  content: provider.notes[index].content!,
                ),
              ),
            ],
          ),
        );

      default:
        return Center(child: Center(child: Text("lahh gaa status nya manee")));
    }
  }
}
