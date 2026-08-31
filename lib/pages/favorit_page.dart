import 'package:flutter/material.dart';
import '../models/contact.dart';

class FavoritPage extends StatelessWidget {
  final List<Contact> daftarFavorit;

  const FavoritPage({super.key, required this.daftarFavorit});

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
          leading: const Icon(Icons.star),
          title: Text(c.nama),
          subtitle: Text('${c.email}\n${c.noHp}'),
          isThreeLine: true,
        );
      },
    );
  }
}
