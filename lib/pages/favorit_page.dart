import 'package:flutter/material.dart';
import '../models/contact.dart';

class FavoritPage extends StatelessWidget {
  final List<Contact> daftarFavorit;
  final void Function(Contact) onToggleFavorit;

  const FavoritPage({
    super.key,
    required this.daftarFavorit,
    required this.onToggleFavorit,
  });

  @override
  Widget build(BuildContext context) {
    if (daftarFavorit.isEmpty) {
      return const Center(child: Text('Belum ada kontak favorit.'));
    }

    return ListView.builder(
      itemCount: daftarFavorit.length,
      itemBuilder: (context, index) {
        final c = daftarFavorit[index];
        return ListTile(
          leading: const Icon(Icons.star, color: Colors.amber),
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