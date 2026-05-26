// import 'package:flutter/material.dart';

// class MainSheet extends StatefulWidget {
//   const MainSheet({super.key});

//   @override
//   State<MainSheet> createState() => _MainSheetState();
// }

// class _MainSheetState extends State<MainSheet> {
//   int pageIndex = 1;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Second Brain"), centerTitle: true),
//       bottomNavigationBar: BottomNavigationBar(
//         onTap: (value) {
//           setState(() {});
//         },
//         currentIndex: pageIndex,

//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.sticky_note_2),
//             label: "Note",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: "Favorite",
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:second_brain/features/notes/presentation/pages/favorite_page.dart';
import 'package:second_brain/features/notes/presentation/pages/home_page.dart';

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
      appBar: AppBar(title: Text("Second Brain"), centerTitle: true),
      body: IndexedStack(index: _currentIndex, children: screen),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
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
    );
  }
}
