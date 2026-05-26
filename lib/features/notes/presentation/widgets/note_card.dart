import 'package:flutter/material.dart';
import 'package:second_brain/core/theme/clr_theme.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key});

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
              "Title card that also can be long text so what this is will be hmmmmm",
              style: TextStyle(
                color: ClrTheme.text1,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Expanded(
              child: Text(
                "this is data card info that will be displayed by card and can get click when user want to if he wasnt that is okay i just sad this is data card info that will be displayed by card and can get click when user want to if he wasnt that is okay i just sad huhu",
                style: TextStyle(color: ClrTheme.textp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
