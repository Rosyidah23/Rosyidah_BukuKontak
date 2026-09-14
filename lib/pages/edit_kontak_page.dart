import 'package:flutter/material.dart';
import '../models/contact.dart';

class EditKontakPage extends StatefulWidget {
  final Contact kontak;

  const EditKontakPage({super.key, required this.kontak});

  @override
  State<EditKontakPage> createState() => _EditKontakPageState();
}

class _EditKontakPageState extends State<EditKontakPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController namaController;
  late TextEditingController emailController;
  late TextEditingController noHpController;
  late TextEditingController kategoriController;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.kontak.nama);
    emailController = TextEditingController(text: widget.kontak.email);
    noHpController = TextEditingController(text: widget.kontak.noHp);
    kategoriController = TextEditingController(text: widget.kontak.kategori ?? '');
  }

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    noHpController.dispose();
    kategoriController.dispose();
    super.dispose();
  }

  void _simpanPerubahan() {
    if (!_formKey.currentState!.validate()) return;

    final kategori = kategoriController.text.trim();

    final kontakBaru = widget.kontak.copyWith(
      nama: namaController.text.trim(),
      email: emailController.text.trim(),
      noHp: noHpController.text.trim(),
      kategori: kategori.isEmpty ? null : kategori,
    );

    Navigator.pop(context, kontakBaru);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Kontak')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(labelText: 'Nama Lengkap'),
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
                decoration: const InputDecoration(labelText: 'Email'),
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
                decoration: const InputDecoration(labelText: 'No Handphone'),
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
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _simpanPerubahan,
                  child: const Text('Simpan Perubahan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
