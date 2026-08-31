// Basic smoke test untuk aplikasi Buku Kontak.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kontak_form/main.dart';

void main() {
  testWidgets('Halaman Beranda menampilkan judul Buku Kontak',
      (WidgetTester tester) async {
    await tester.pumpWidget(const BukuKontakApp());

    expect(find.text('BUKU KONTAK'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('Kontak Marisa Arpilya Hapsari hanya tampil di halaman favorit',
      (WidgetTester tester) async {
    await tester.pumpWidget(const BukuKontakApp());

    expect(find.text('Marisa Arpilya Hapsari'), findsNothing);

    await tester.tap(find.text('Favorit'));
    await tester.pumpAndSettle();

    expect(find.text('Marisa Arpilya Hapsari'), findsOneWidget);
    expect(find.textContaining('marisaaprilya1@gmail.com'), findsOneWidget);
    expect(find.textContaining('087826762981'), findsOneWidget);
  });
}