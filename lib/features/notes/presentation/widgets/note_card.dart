import 'package:flutter/material.dart';
import 'package:second_brain/core/theme/clr_theme.dart';
import 'package:second_brain/features/notes/domain/entities/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final String? kategoriName;
  final VoidCallback? onTap;

  const NoteCard({
    super.key,
    required this.note,
    this.kategoriName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: ClrTheme.primary),
        ),
        color: ClrTheme.secondary,
        shadowColor: Colors.white54,
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (kategoriName != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),

                  child: Text(
                    kategoriName!,
                    style: TextStyle(
                      color: ClrTheme.text1,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if (kategoriName != null) const SizedBox(height: 4),
              Text(
                note.title ?? "",
                style: TextStyle(
                  color: ClrTheme.text1,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  note.content,
                  style: TextStyle(color: ClrTheme.textp),
                  overflow: TextOverflow.fade,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
