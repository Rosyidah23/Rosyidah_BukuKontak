import 'dart:async';
import 'package:flutter/material.dart';
import '../models/contact.dart';

class KontakPage extends StatefulWidget {
  final List<Contact> daftarKontak;
  final void Function(Contact) onToggleFavorit;

  const KontakPage({
    super.key,
    required this.daftarKontak,
    required this.onToggleFavorit,
  });

  @override
  State<KontakPage> createState() => _KontakPageState();
}

class _KontakPageState extends State<KontakPage> {
  final StreamController<String> _searchController =
      StreamController<String>.broadcast();

  @override
  void dispose() {
    _searchController.close();
    super.dispose();
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
            builder: (context, snapshot) {
              final keyword = (snapshot.data ?? '').toLowerCase();
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
                  final inisial =
                      c.nama.isNotEmpty ? c.nama[0].toUpperCase() : '?';
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(inisial),
                    ),
                    title: Text(c.nama),
                    subtitle: Text(
                      '${c.email}\n${c.noHp}\n${c.kategori ?? 'Tanpa kategori'}',
                    ),
                    isThreeLine: true,
                    trailing: IconButton(
                      onPressed: () => widget.onToggleFavorit(c),
                      icon: Icon(
                        c.isFavorit ? Icons.star : Icons.star_border,
                        color: c.isFavorit ? Colors.amber : Colors.grey,
                      ),
                      tooltip: c.isFavorit
                          ? 'Hapus dari favorit'
                          : 'Tambah ke favorit',
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