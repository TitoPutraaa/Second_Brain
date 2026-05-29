import 'package:second_brain/features/notes/domain/entities/note.dart';

class NoteModel extends Note {
  const NoteModel({
    super.idNote,
    super.idKategori,
    required super.content,
    super.title,
    super.isFavorite,
    super.isDeleted,
  });

  factory NoteModel.fromMap(Map<String, dynamic> data) {
    return NoteModel(
      idNote: data["idNote"],
      idKategori: data["idKategori"],
      title: data["title"] ?? "",
      content: data["content"],
      isFavorite: data["isFavorite"] ?? 0,
      isDeleted: data["isDeleted"] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (idNote != null) 'idNote': idNote,
      "idKategori": idKategori,
      "content": content,
      "title": title,
      "isFavorite": isFavorite,
      "isDeleted": isDeleted,
    };
  }
}
