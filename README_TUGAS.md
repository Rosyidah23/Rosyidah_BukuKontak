# kontak_form — Buku Kontak (Navigasi & Routing)

Ini adalah project **kontak_form** kamu yang asli (lengkap dengan folder
android/ios/web/dll), dengan `lib/` yang sudah dikembangkan mengikuti
LKPD *Navigasi dan Routing* — tidak ada yang ditimpa dari nol, kode form
dan list kontak asli kamu tetap dipakai, hanya dipindah & dirapikan jadi
beberapa halaman.

## Cara pakai

1. Extract zip ini.
2. Buka foldernya di VS Code / Android Studio seperti project Flutter
   biasa.
3. Jalankan:
   ```
   flutter pub get
   flutter run
   ```

## Apa yang berubah dari project asli

| File asli | Jadi |
|---|---|
| `lib/main.dart` (form + list jadi satu) | Dipecah jadi `lib/pages/kontak_page.dart` (daftar) dan `lib/pages/tambah_kontak_page.dart` (form), keduanya dihubungkan lewat `Navigator.push` / `Navigator.pop` |
| Model `Contact` di dalam `main.dart` | Dipindah ke `lib/models/contact.dart`, ditambah field `isFavorit` |
| — | `lib/pages/home_page.dart` baru: AppBar + Navigation Drawer + TabBar/TabBarView + FloatingActionButton |
| — | `lib/pages/favorit_page.dart` baru: menampilkan kontak favorit, atau teks "Belum ada kontak favorit." |
| Profil dari project `profil_siswa` (Rosyidah Alif Hakimah, XII RPL B, SMK Negeri 5 Surakarta + foto) | `lib/pages/tentang_page.dart`, foto disalin ke `assets/images/foto.jpeg` dan didaftarkan di `pubspec.yaml` |

Project `widgetdasar1` tidak dipakai karena isinya latihan widget dasar,
tidak terkait konten LKPD ini.

## Pemetaan ke poin LKPD

| Poin LKPD | File |
|---|---|
| 1. Halaman Beranda (AppBar, Drawer, TabBar, TabBarView, FAB) | `lib/pages/home_page.dart` |
| 2. FloatingActionButton → Tambah Kontak | `lib/pages/home_page.dart` |
| 3. Navigation Drawer (Kontak, Tambah Kontak, Favorit, Tentang) | `lib/pages/home_page.dart` |
| 4. Halaman Tambah Kontak | `lib/pages/tambah_kontak_page.dart` |
| 5. Halaman Kontak | `lib/pages/kontak_page.dart` |
| 6. Halaman Favorit | `lib/pages/favorit_page.dart` |
| 7. Halaman Tentang | `lib/pages/tentang_page.dart` |

## Tugas 2 & 3 (harus kamu lakukan sendiri di akun GitHub-mu)

**Tugas 2 — Push ke GitHub**
```
git init
git add .
git commit -m "Buku Kontak dengan Navigasi dan Routing"
git branch -M main
git remote add origin https://github.com/<username>/<Nama>_BukuKontak.git
git push -u origin main
```

**Tugas 3 — Fork, Clone, Commit, Push, Pull Request**
1. Buka repo GitHub temanmu → klik **Fork** → **Create Fork**.
2. Clone hasil fork:
   ```
   git clone <link-repo-hasil-fork>
   ```
3. Tambahkan data dirimu (Nama, Email, No. HP) pada bagian Favorit di
   project hasil clone (misalnya lewat form Tambah Kontak lalu tandai
   favorit).
4. Commit & push:
   ```
   git status
   git add .
   git commit -m "Menambahkan kontak pada menu favorit"
   git push -u origin main
   ```
5. Di GitHub, klik **Create Pull Request** dari repo hasil fork ke repo
   asli temanmu.
6. Minta pasanganmu **Merge** Pull Request tersebut.

Ambil screenshot di tiap langkah untuk dilampirkan di LKM sebagai bukti
kegiatan.
