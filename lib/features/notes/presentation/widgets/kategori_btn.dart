import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const List<String> kategoriList = ["Personal", "Work", "Hobby"];

class KategoriBtn extends StatefulWidget {
  const KategoriBtn({super.key});

  @override
  State<KategoriBtn> createState() => _KategoriBtnState();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _KategoriBtnState extends State<KategoriBtn> {
  static final List<MenuEntry> menuEntries = UnmodifiableListView<MenuEntry>(
    kategoriList.map<MenuEntry>(
      (String name) => MenuEntry(value: name, label: name),
    ),
  );

  String dropDownValue = kategoriList.first;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),

      child: DropdownMenu(
        width: double.infinity,
        dropdownMenuEntries: menuEntries,
        initialSelection: kategoriList.first,
        onSelected: (String? value) {
          setState(() {
            dropDownValue = value!;
          });
        },
      ),
    );
  }
}
