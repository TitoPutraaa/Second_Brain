import 'package:flutter/material.dart';
import 'package:second_brain/core/theme/clr_theme.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final String content;
  const NoteCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(10),
        side: BorderSide(color: ClrTheme.primary),
      ),
      color: ClrTheme.secondary,
      shadowColor: Colors.white54,
      child: Padding(
        padding: const EdgeInsets.all(9),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: ClrTheme.text1,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Expanded(
              child: Text(content, style: TextStyle(color: ClrTheme.textp)),
            ),
          ],
        ),
      ),
    );
  }
}
