import 'package:flutter/material.dart';
import '../models/contact.dart';

class KontakPage extends StatelessWidget {
  final List<Contact> daftarKontak;
  final void Function(Contact) onToggleFavorit;

  const KontakPage({
    super.key,
    required this.daftarKontak,
    required this.onToggleFavorit,
  });

  @override
  Widget build(BuildContext context) {
    if (daftarKontak.isEmpty) {
      return const Center(child: Text('Belum ada kontak'));
    }

    final daftarKontakUmum = daftarKontak.where((c) => !c.isFavorit).toList();

    if (daftarKontakUmum.isEmpty) {
      return const Center(child: Text('Belum ada kontak'));
    }

    return ListView.builder(
      itemCount: daftarKontakUmum.length,
      itemBuilder: (context, index) {
        final c = daftarKontakUmum[index];
        final inisial = c.nama.isNotEmpty ? c.nama[0].toUpperCase() : '?';
        return ListTile(
          leading: CircleAvatar(
            child: Text(inisial),
          ),
          title: Text(c.nama),
          subtitle: Text('${c.email}\n${c.noHp}\n${c.kategori ?? 'Tanpa kategori'}'),
          isThreeLine: true,
          trailing: IconButton(
            onPressed: () => onToggleFavorit(c),
            icon: Icon(
              c.isFavorit ? Icons.star : Icons.star_border,
              color: c.isFavorit ? Colors.amber : Colors.grey,
            ),
            tooltip: c.isFavorit ? 'Hapus dari favorit' : 'Tambah ke favorit',
          ),
        );
      },
    );
  }
}