class Contact {
  final String nama;
  final String email;
  final String noHp;
  final bool isFavorit;

  Contact({
    required this.nama,
    required this.email,
    required this.noHp,
    this.isFavorit = false,
  });

  Contact copyWith({
    String? nama,
    String? email,
    String? noHp,
    bool? isFavorit,
  }) {
    return Contact(
      nama: nama ?? this.nama,
      email: email ?? this.email,
      noHp: noHp ?? this.noHp,
      isFavorit: isFavorit ?? this.isFavorit,
    );
  }
}
