import 'package:equatable/equatable.dart';

class Kategori extends Equatable {
  final int? idKategori;
  final String kategoriName;

  const Kategori({this.idKategori, required this.kategoriName});

  @override
  List<Object?> get props => [idKategori, kategoriName];
}
