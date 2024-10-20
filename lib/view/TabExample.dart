import 'package:flutter/material.dart';

class CustomTabExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Jumlah tab
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255), // Warna background
        body: Column(
          children: [
            // TabBar tanpa AppBar
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
              ),
              child: TabBar(
                labelColor: const Color.fromARGB(
                    255, 0, 0, 0), // Warna teks saat tab aktif
                unselectedLabelColor:
                    Colors.black, // Warna teks saat tab tidak aktif
                indicatorColor: const Color.fromARGB(
                    255, 0, 132, 255), // Warna indikator tab
                tabs: [
                  Tab(text: 'Status Terakhir'),
                  Tab(text: 'Grafik'),
                ],
              ),
            ),
            // TabBarView untuk konten masing-masing tab
            Expanded(
              child: TabBarView(
                children: [
                  StatusTerakhirTab(), // Konten untuk tab Status Terakhir
                  GrafikTab(), // Konten untuk tab Grafik
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatusTerakhirTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: [
        ListTile(
          title: Text('Titik Pantau Klego (02-Okt-2024 14:00)'),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/example.png', // Gambar yang ingin ditampilkan
                width: 120, // Lebar gambar
                height: 120, // Tinggi gambar
              ),

              SizedBox(width: 10), // Jarak antara teks dan gambar
              Expanded(
                child: Text(
                  'Status: Siaga\nKetinggian Air: 1120 cm\nCurah Hujan: 5 mm\nKecepatan Angin: 7 km/h',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: Text('Titik Pantau Yosorejo (02-Okt-2024 14:00)'),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/images/example.png', // Gambar yang ingin ditampilkan
                width: 120,
                height: 120,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Status: Aman\nKetinggian Air: 140 cm\nCurah Hujan: 5 mm\nKecepatan Angin: 7 km/h',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}

class GrafikTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Grafik akan ditampilkan di sini.'),
    );
  }
}

void main() {
  runApp(CustomTabExample());
}
