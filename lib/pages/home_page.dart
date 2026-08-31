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

    final marisa = Contact(
      nama: 'Marisa Arpilya Hapsari',
      email: 'marisaaprilya1@gmail.com',
      noHp: '087826762981',
      isFavorit: true,
    );

    _daftarFavorit.add(marisa.copyWith());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _toggleFavorit(Contact kontak) {
    final indexKontak = _daftarKontak.indexWhere(
      (item) =>
          item.nama == kontak.nama &&
          item.email == kontak.email &&
          item.noHp == kontak.noHp,
    );

    if (indexKontak == -1) return;

    final kontakBaru = _daftarKontak[indexKontak].copyWith(
      isFavorit: !_daftarKontak[indexKontak].isFavorit,
    );

    setState(() {
      _daftarKontak[indexKontak] = kontakBaru;

      if (kontakBaru.isFavorit) {
        final sudahAda = _daftarFavorit.any(
          (item) =>
              item.nama == kontakBaru.nama &&
              item.email == kontakBaru.email &&
              item.noHp == kontakBaru.noHp,
        );

        if (!sudahAda) {
          _daftarFavorit.add(kontakBaru.copyWith());
        }
      } else {
        _daftarFavorit.removeWhere(
          (item) =>
              item.nama == kontakBaru.nama &&
              item.email == kontakBaru.email &&
              item.noHp == kontakBaru.noHp,
        );
      }
    });
  }

  Future<void> _bukaTambahKontak() async {
    final kontakBaru = await Navigator.push<Contact>(
      context,
      MaterialPageRoute(builder: (context) => const TambahKontakPage()),
    );

    if (kontakBaru != null) {
      setState(() {
        _daftarKontak.add(kontakBaru);
        if (kontakBaru.isFavorit) {
          _daftarFavorit.add(kontakBaru.copyWith());
        }
      });
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
          KontakPage(
            daftarKontak: _daftarKontak,
            onToggleFavorit: _toggleFavorit,
          ),
          FavoritPage(
            daftarFavorit: _daftarFavorit,
            onToggleFavorit: _toggleFavorit,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _bukaTambahKontak,
        child: const Icon(Icons.add),
      ),
    );
  }
}