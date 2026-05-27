import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final int? idNote;
  final int idKategori;
  final String? title;
  final String? content;
  final bool? isFavorite, isDeleted;

  const Note({
    this.idNote,
    required this.idKategori,
    this.content,
    this.title,
    this.isFavorite,
    this.isDeleted,
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
