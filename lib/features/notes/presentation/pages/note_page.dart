import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_brain/features/notes/presentation/provider/notes_provider.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final TextEditingController title = TextEditingController();
  final TextEditingController content = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite),
            iconSize: 33,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.check_circle),
            iconSize: 40,
            color: Colors.green,
            padding: EdgeInsets.symmetric(horizontal: 20),
          ),
        ],
      ),
      body: Consumer<NotesProvider>(
        builder: (context, provider, widget) {
          switch (provider.status) {
            case NotesStatus.loading:
              return Center(child: CircularProgressIndicator());
            case NotesStatus.success:
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  child: Column(
                    children: [
                      TextField(
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                        controller: title,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        minLines: 1,
                        decoration: const InputDecoration(
                          hintText: "Title",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                      TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        minLines: 1,
                        controller: content,
                        decoration: const InputDecoration(
                          hint: Text("note"),
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            case NotesStatus.error:
              return Center(child: Text(provider.errorMessage));

            default:
          }
          return Center(child: Text("lahh error cuy"));
        },
      ),
    );
  }
}
