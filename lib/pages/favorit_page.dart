import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/contact.dart';

class FavoritPage extends StatelessWidget {
  final List<Contact> daftarFavorit;

  const FavoritPage({super.key, required this.daftarFavorit});

  Future<void> _toggleFavorit(Contact kontak) async {
    await FirebaseFirestore.instance
        .collection('kontak')
        .doc(kontak.id)
        .update({'isFavorit': !kontak.isFavorit});
  }

  @override
  Widget build(BuildContext context) {
    if (daftarFavorit.isEmpty) {
      return const Center(child: Text('Belum ada kontak favorit'));
    }

    return ListView.builder(
      itemCount: daftarFavorit.length,
      itemBuilder: (context, index) {
        final c = daftarFavorit[index];

        return ListTile(
          leading: CircleAvatar(child: Text(c.inisial)),
          title: Text(c.nama),
          subtitle: Text(
            '${c.email}\n${c.noHandphone}\n${c.kategori ?? 'Tanpa kategori'}',
          ),
          isThreeLine: true,
          trailing: IconButton(
            onPressed: () => _toggleFavorit(c),
            icon: const Icon(Icons.star, color: Colors.amber),
            tooltip: 'Hapus dari favorit',
          ),
        );
      },
    );
  }
}
