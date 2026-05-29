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
}
