class Contact {
  final String id;
  final String nama;
  final String email;
  final String noHandphone;
  final bool isFavorit;
  final String? kategori;

  Contact({
    this.id = '',
    required this.nama,
    required this.email,
    required this.noHandphone,
    this.isFavorit = false,
    this.kategori,
  });

  String get inisial => nama.isNotEmpty ? nama[0].toUpperCase() : '?';

  Contact copyWith({
    String? id,
    String? nama,
    String? email,
    String? noHandphone,
    bool? isFavorit,
    String? kategori,
  }) {
    return Contact(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      email: email ?? this.email,
      noHandphone: noHandphone ?? this.noHandphone,
      isFavorit: isFavorit ?? this.isFavorit,
      kategori: kategori ?? this.kategori,
    );
  }

  // Ubah objek Contact jadi Map, dipakai waktu kirim data ke Firestore
  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'email': email,
      'noHandphone': noHandphone,
      'isFavorit': isFavorit,
      'kategori': kategori,
    };
  }

  // Bikin objek Contact dari satu dokumen Firestore
  factory Contact.fromFirestore(String id, Map<String, dynamic> data) {
    return Contact(
      id: id,
      nama: data['nama'] ?? '',
      email: data['email'] ?? '',
      noHandphone: data['noHandphone'] ?? '',
      isFavorit: data['isFavorit'] ?? false,
      kategori: data['kategori'],
    );
  }
}
