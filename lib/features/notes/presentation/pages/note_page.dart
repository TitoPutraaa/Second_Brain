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
  bool _isSaving = false;

  Future<void> _submit() async {
    final provider = context.read<NotesProvider>();

    setState(() => _isSaving = true);

    await provider.saveNewNote(title: title.text, content: content.text);

    if (!mounted) return;

    if (provider.status == NotesStatus.error) {
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(provider.errorMessage)));
    } else {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    title.dispose();
    content.dispose();
    super.dispose();
  }

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
            onPressed: _isSaving ? null : _submit,
            icon: Icon(Icons.check_circle),
            iconSize: 40,
            color: Colors.green,
            padding: EdgeInsets.symmetric(horizontal: 20),
          ),
        ],
      ),
      body: Consumer<NotesProvider>(
        builder: (context, provider, widget) {
          if (provider.status == NotesStatus.loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (provider.status == NotesStatus.error) {
            return Center(child: Text(provider.errorMessage));
          }

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
                      hintText: "note",
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
