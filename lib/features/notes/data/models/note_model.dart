import 'package:second_brain/features/notes/domain/entities/note.dart';

class NoteModel extends Note {
  const NoteModel({
    required super.idNote,
    required super.idKategori,
    required super.content,
    required super.judul,
    required super.isFavorite,
    required super.isDeleted,
  });

  factory NoteModel.fromMap(Map<String, dynamic> data) {
    return NoteModel(
      idNote: data["idNote"],
      idKategori: data["idKategori"],
      content: data["content"],
      judul: data["judul"],
      isFavorite: data["isFavorite"],
      isDeleted: data["isDeleted"],
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
