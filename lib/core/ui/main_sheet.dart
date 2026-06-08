import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_brain/features/notes/presentation/pages/favorite_page.dart';
import 'package:second_brain/features/notes/presentation/pages/home_page.dart';
import 'package:second_brain/features/notes/presentation/pages/note_page.dart';
import 'package:second_brain/features/notes/presentation/provider/notes_provider.dart';

class MainSheet extends StatefulWidget {
  const MainSheet({super.key});

  @override
  State<MainSheet> createState() => _MainSheetState();
}

class _MainSheetState extends State<MainSheet> {
  int _currentIndex = 0;

  final List<Widget> screen = [HomePage(), FavoritePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Brain"),
        centerTitle: true,
        elevation: 2,
      ),
      body: IndexedStack(index: _currentIndex, children: screen),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          if (index == 0) {
            context.read<NotesProvider>().getAllNotes();
          } else if (index == 1) {
            context.read<NotesProvider>().getFavoriteNotesProvider(1);
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.sticky_note_2),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorite",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotePage()),
          );
        },
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white38),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(Icons.add, fontWeight: FontWeight.w700),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
