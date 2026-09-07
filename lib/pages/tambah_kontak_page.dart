import 'package:flutter/material.dart';
import '../models/contact.dart';

class TambahKontakPage extends StatefulWidget {
  const TambahKontakPage({super.key});

  @override
  State<TambahKontakPage> createState() => _TambahKontakPageState();
}

class _TambahKontakPageState extends State<TambahKontakPage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController noHpController = TextEditingController();
  final TextEditingController kategoriController = TextEditingController();
  bool _isFavorit = false;

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    noHpController.dispose();
    kategoriController.dispose();
    super.dispose();
  }

  void _simpanKontak() {
    if (namaController.text.trim().isEmpty) return;

    final kategoriText = kategoriController.text.trim();
    final kontakBaru = Contact(
      nama: namaController.text,
      email: emailController.text,
      noHp: noHpController.text,
      isFavorit: _isFavorit,
      kategori: kategoriText.isEmpty ? null : kategoriText,
    );

    Navigator.pop(context, kontakBaru);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Kontak'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: noHpController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'No Handphone',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: kategoriController,
              decoration: const InputDecoration(
                labelText: 'Kategori (opsional)',
                hintText: 'Keluarga / Teman / Kerja',
              ),
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              value: _isFavorit,
              onChanged: (value) {
                setState(() => _isFavorit = value ?? false);
              },
              title: const Text('Jadikan kontak favorit'),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _simpanKontak,
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}