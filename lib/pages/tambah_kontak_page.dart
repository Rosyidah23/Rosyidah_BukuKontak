import 'package:flutter/material.dart';
import '../models/contact.dart';

class TambahKontakPage extends StatefulWidget {
  const TambahKontakPage({super.key});

  @override
  State<TambahKontakPage> createState() => _TambahKontakPageState();
}

class _TambahKontakPageState extends State<TambahKontakPage> {
  final _formKey = GlobalKey<FormState>();

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
    if (!_formKey.currentState!.validate()) return;

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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email wajib diisi';
                  }
                  if (!value.contains('@')) {
                    return 'Email harus mengandung karakter @';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: noHpController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'No Handphone',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'No Handphone wajib diisi';
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'No Handphone hanya boleh angka';
                  }
                  if (value.length < 10) {
                    return 'No Handphone minimal 10 digit';
                  }
                  return null;
                },
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
      ),
    );
  }
}