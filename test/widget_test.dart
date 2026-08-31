// Basic smoke test untuk aplikasi Buku Kontak.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kontak_form/main.dart';

void main() {
  testWidgets('Halaman Beranda menampilkan judul Buku Kontak',
      (WidgetTester tester) async {
    await tester.pumpWidget(const BukuKontakApp());

    expect(find.text('Buku Kontak'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}