import 'package:second_brain/features/notes/domain/entities/note.dart';

class NoteModel extends Note {
  const NoteModel({
    super.idNote,
    required super.idKategori,
    super.content,
    super.judul,
    super.isFavorite,
    super.isDeleted,
  });

  factory NoteModel.fromMap(Map<String, dynamic> data) {
    return NoteModel(
      idNote: data["idNote"],
      idKategori: data["idKategori"],
      judul: data["judul"] ?? "",
      content: data["content"],
      isFavorite: data["isFavorite"] ?? 0,
      isDeleted: data["isDeleted"] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "idNote": idNote,
      "idKategori": idKategori,
      "content": content,
      "judul": judul,
      "isFavorite": isFavorite,
      "isDeleted": isDeleted,
    };
  }
}
