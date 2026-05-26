import 'package:flutter/material.dart';
import 'package:second_brain/features/notes/presentation/widgets/kategori_btn.dart';
import 'package:second_brain/features/notes/presentation/widgets/note_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: KategoriBtn()),
        SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3.5 / 4,
            crossAxisSpacing: 5,
            mainAxisSpacing: 3,
          ),
          itemCount: 9,
          itemBuilder: (BuildContext context, int index) {
            return NoteCard();
          },
        ),
      ],
    );
  }
}
