class Contact {
  final String nama;
  final String email;
  final String noHp;
  final bool isFavorit;
  final String? kategori;

  Contact({
    required this.nama,
    required this.email,
    required this.noHp,
    this.isFavorit = false,
    this.kategori,
  });

  Contact copyWith({
    String? nama,
    String? email,
    String? noHp,
    bool? isFavorit,
    String? kategori,
  }) {
    return Contact(
      nama: nama ?? this.nama,
      email: email ?? this.email,
      noHp: noHp ?? this.noHp,
      isFavorit: isFavorit ?? this.isFavorit,
      kategori: kategori ?? this.kategori,
    );
  }
}