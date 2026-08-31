import 'package:flutter/material.dart';
import '../models/contact.dart';
import 'kontak_page.dart';
import 'favorit_page.dart';
import 'tentang_page.dart';
import 'tambah_kontak_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Contact> _daftarKontak = [];
  final List<Contact> _daftarFavorit = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _bukaTambahKontak() async {
    final kontakBaru = await Navigator.push<Contact>(
      context,
      MaterialPageRoute(builder: (context) => const TambahKontakPage()),
    );

    if (kontakBaru != null) {
      setState(() => _daftarKontak.add(kontakBaru));
      _tabController.animateTo(0);
    }
  }

  void _pindahTab(int index) {
    Navigator.pop(context);
    _tabController.animateTo(index);
  }

  void _bukaTentang() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TentangPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BUKU KONTAK'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.person), text: 'Kontak'),
            Tab(icon: Icon(Icons.star), text: 'Favorit'),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'BUKU KONTAK',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Kontak'),
              onTap: () => _pindahTab(0),
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Tambah Kontak'),
              onTap: () {
                Navigator.pop(context);
                _bukaTambahKontak();
              },
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Favorit'),
              onTap: () => _pindahTab(1),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Tentang'),
              onTap: _bukaTentang,
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          KontakPage(daftarKontak: _daftarKontak),
          FavoritPage(daftarFavorit: _daftarFavorit),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _bukaTambahKontak,
        child: const Icon(Icons.add),
      ),
    );
  }
}