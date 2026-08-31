import 'package:flutter/material.dart';
import '../models/contact.dart';

class KontakPage extends StatelessWidget {
  final List<Contact> daftarKontak;

  const KontakPage({super.key, required this.daftarKontak});

  @override
  Widget build(BuildContext context) {
    if (daftarKontak.isEmpty) {
      return const Center(child: Text('Belum ada kontak'));
    }

    return ListView.builder(
      itemCount: daftarKontak.length,
      itemBuilder: (context, index) {
        final c = daftarKontak[index];
        return ListTile(
          leading: const Icon(Icons.person),
          title: Text(c.nama),
          subtitle: Text('${c.email}\n${c.noHp}'),
          isThreeLine: true,
        );
      },
    );
  }
}
