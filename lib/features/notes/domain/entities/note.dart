import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final int? idNote;
  final int? idKategori;
  final String? title;
  final String content;
  final int isFavorite;
  final int isDeleted;

  const Note({
    this.idNote,
    this.idKategori,
    required this.content,
    this.title,
    this.isFavorite = 0,
    this.isDeleted = 0,
  });

  @override
  List<Object?> get props => [
    idNote,
    idKategori,
    content,
    title,
    isFavorite,
    isDeleted,
  ];

  Note copyWith({
    int? idKategori,
    String? title,
    String? content,
    int? isFavorite,
    int? isDeleted,
  }) {
    return Note(
      idNote: idNote,
      idKategori: idKategori ?? this.idKategori,
      title: title ?? this.title,
      content: content ?? this.content,
      isFavorite: isFavorite ?? this.isFavorite,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
