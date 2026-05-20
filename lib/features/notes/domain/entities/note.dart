import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final int idNote;
  final int idKategori;
  final String judul, content;
  final bool isFavorite, isDeleted;

  const Note({
    required this.idNote,
    required this.idKategori,
    required this.content,
    required this.judul,
    required this.isFavorite,
    required this.isDeleted,
  });

  @override
  List<Object?> get props => [
    idNote,
    idKategori,
    content,
    judul,
    isFavorite,
    isDeleted,
  ];
}
