import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/contact.dart';
import 'edit_kontak_page.dart';

class KontakPage extends StatefulWidget {
  final List<Contact> daftarKontak;

  const KontakPage({
    super.key,
    required this.daftarKontak,
  });

  @override
  State<KontakPage> createState() => _KontakPageState();
}

class _KontakPageState extends State<KontakPage> {
  final StreamController<String> _searchController =
      StreamController<String>.broadcast();
  final _kontakRef = FirebaseFirestore.instance.collection('kontak');

  @override
  void dispose() {
    _searchController.close();
    super.dispose();
  }

  Future<void> _toggleFavorit(Contact kontak) async {
    await _kontakRef.doc(kontak.id).update({'isFavorit': !kontak.isFavorit});
  }

  Future<void> _bukaEditKontak(Contact kontak) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditKontakPage(kontak: kontak)),
    );
  }

  Future<void> _konfirmasiHapus(Contact kontak) async {
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Kontak'),
        content: Text('Yakin ingin menghapus kontak "${kontak.nama}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (konfirmasi == true) {
      await _kontakRef.doc(kontak.id).delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    final daftarKontakUmum =
        widget.daftarKontak.where((c) => !c.isFavorit).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'Cari nama atau kategori',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (teks) => _searchController.add(teks),
          ),
        ),
        Expanded(
          child: StreamBuilder<String>(
            stream: _searchController.stream,
            initialData: '',
            builder: (context, searchSnapshot) {
              final keyword = (searchSnapshot.data ?? '').toLowerCase();
              final hasil = daftarKontakUmum.where((c) {
                final namaCocok = c.nama.toLowerCase().contains(keyword);
                final kategoriCocok =
                    (c.kategori ?? '').toLowerCase().contains(keyword);
                return namaCocok || kategoriCocok;
              }).toList();

              if (hasil.isEmpty) {
                return const Center(child: Text('Belum ada kontak'));
              }

              return ListView.builder(
                itemCount: hasil.length,
                itemBuilder: (context, index) {
                  final c = hasil[index];

                  return ListTile(
                    leading: CircleAvatar(child: Text(c.inisial)),
                    title: Text(c.nama),
                    subtitle: Text(
                      '${c.email}\n${c.noHandphone}\n${c.kategori ?? 'Tanpa kategori'}',
                    ),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => _toggleFavorit(c),
                          icon: Icon(
                            c.isFavorit ? Icons.star : Icons.star_border,
                            color: c.isFavorit ? Colors.amber : Colors.grey,
                          ),
                          tooltip: c.isFavorit
                              ? 'Hapus dari favorit'
                              : 'Tambah ke favorit',
                        ),
                        IconButton(
                          onPressed: () => _bukaEditKontak(c),
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          tooltip: 'Edit Kontak',
                        ),
                        IconButton(
                          onPressed: () => _konfirmasiHapus(c),
                          icon: const Icon(Icons.delete, color: Colors.red),
                          tooltip: 'Hapus Kontak',
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
