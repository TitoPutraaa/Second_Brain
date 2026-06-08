import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_brain/features/notes/presentation/provider/notes_provider.dart';

class KategoriBtn extends StatefulWidget {
  const KategoriBtn({super.key});

  @override
  State<KategoriBtn> createState() => _KategoriBtnState();
}

class _KategoriBtnState extends State<KategoriBtn> {
  int? selectedKategoriId;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotesProvider>();
    final categories = provider.categories;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<int?>(
                  decoration: const InputDecoration(
                    labelText: "Filter by Category",
                    border: OutlineInputBorder(),
                  ),
                  value: selectedKategoriId,
                  items: [
                    const DropdownMenuItem<int?>(
                      value: null,
                      child: Text("All Notes"),
                    ),
                    ...categories.map(
                      (cat) => DropdownMenuItem<int?>(
                        value: cat.idKategori,
                        child: Text(cat.kategoriName),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedKategoriId = value;
                    });
                    if (value == null) {
                      provider.getAllNotes();
                    } else {
                      provider.getNotesByCategoryProvider(value);
                    }
                  },
                ),
              ),
              IconButton(
                onPressed: () => _showAddKategoriDialog(context),
                icon: const Icon(Icons.add_circle_outline),
                tooltip: "Add Category",
              ),
            ],
          ),
        ],
      ),
    );
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
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    context.read<NotesProvider>().addKategoriProvider(
                      controller.text,
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text("Add"),
              ),
            ],
          ),
    );
  }
}
