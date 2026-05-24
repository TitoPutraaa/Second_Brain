import 'package:second_brain/features/notes/domain/entities/kategori.dart';

class KategoriModel extends Kategori {
  const KategoriModel({super.idKategori, required super.kategoriName});

  factory KategoriModel.fromMap(Map<String, dynamic> data) {
    return KategoriModel(
      idKategori: data["idKategori"],
      kategoriName: data["kategoriName"],
    );
  }

  Map<String, dynamic> toMap() {
    return {"idKategori": idKategori, "kategoriName": kategoriName};
  }
}
