import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_brain/features/notes/domain/entities/note.dart';
import 'package:second_brain/features/notes/presentation/provider/notes_provider.dart';

class NotePage extends StatefulWidget {
  final Note? note;
  const NotePage({super.key, this.note});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late TextEditingController title;
  late TextEditingController content;
  bool _isSaving = false;
  late int _isFavorite;
  int? _selectedKategoriId;

  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: widget.note?.title);
    content = TextEditingController(text: widget.note?.content);
    _isFavorite = widget.note?.isFavorite ?? 0;
    _selectedKategoriId = widget.note?.idKategori;
  }

  Future<void> _submit() async {
    final provider = context.read<NotesProvider>();

    setState(() => _isSaving = true);

    if (widget.note == null) {
      await provider.saveNewNote(
        title: title.text,
        content: content.text,
        isFavorite: _isFavorite,
        idKategori: _selectedKategoriId,
      );
    } else {
      final updatedNote = widget.note!.copyWith(
        title: title.text,
        content: content.text,
        isFavorite: _isFavorite,
        idKategori: _selectedKategoriId,
      );
      await provider.updateNoteProvider(updatedNote);
    }

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

  void _toggleFavorite() {
    setState(() {
      _isFavorite = _isFavorite == 0 ? 1 : 0;
    });
  }

  void _showAddKategoriDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Add Category"),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: "Category Name"),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {
                  if (controller.text.isNotEmpty) {
                    await context.read<NotesProvider>().addKategoriProvider(
                      controller.text,
                    );
                    if (mounted) Navigator.pop(context);
                  }
                },
                child: const Text("Add"),
              ),
            ],
          ),
    );
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
          if (widget.note != null)
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Delete Note"),
                    content: const Text(
                      "Are you sure you want to delete this note?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await context
                              .read<NotesProvider>()
                              .deleteNoteProvider(widget.note!.idNote!);
                          if (mounted) Navigator.pop(context);
                        },
                        child: const Text(
                          "Delete",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.delete),
              color: Colors.redAccent,
            ),
          IconButton(
            onPressed: _toggleFavorite,
            icon: Icon(
              _isFavorite == 1 ? Icons.favorite : Icons.favorite_border,
            ),
            iconSize: 33,
            color: _isFavorite == 1 ? Colors.red : null,
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
                  Row(
                    children: [
                      const Icon(
                        Icons.category_outlined,
                        size: 20,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButton<int?>(
                          value: _selectedKategoriId,
                          hint: const Text("Select Category"),
                          isExpanded: true,
                          underline: const SizedBox(),
                          items: [
                            const DropdownMenuItem<int?>(
                              value: null,
                              child: Text("No Category"),
                            ),
                            ...provider.categories.map(
                              (cat) => DropdownMenuItem<int?>(
                                value: cat.idKategori,
                                child: Text(cat.kategoriName),
                              ),
                            ),
                            const DropdownMenuItem<int?>(
                              value: -1,
                              child: Row(
                                children: [
                                  Icon(Icons.add, size: 18),
                                  SizedBox(width: 8),
                                  Text("Add New Category"),
                                ],
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            if (value == -1) {
                              _showAddKategoriDialog(context);
                            } else {
                              setState(() {
                                _selectedKategoriId = value;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  TextField(
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
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
