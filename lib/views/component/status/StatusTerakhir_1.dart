import 'package:flutter/material.dart';

class StatusTerakhir1Tab extends StatelessWidget {
  const StatusTerakhir1Tab({super.key});

  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 14), // Jarak antar ListTile
      child: ListTile(
        title: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5), // Sudut kiri atas tumpul
              topRight: Radius.circular(5), // Sudut kanan atas tumpul
              bottomLeft: Radius.circular(0), // Sudut kiri bawah tajam
              bottomRight: Radius.circular(0), // Sudut kanan bawah tajam
            ),
          ),
          child: Text(
            'Titik Pantau Klego (02-Okt-2024 14:00)',
            style: TextStyle(
              fontSize: hp * 0.014,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(
              top: 10), // Menambahkan jarak vertikal antara title dan subtitle
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/example.png', // Gambar yang ingin ditampilkan
                width: 100, // Lebar gambar
                height: 100, // Tinggi gambar
              ),
              SizedBox(width: 10), // Jarak antara teks dan gambar
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Membuat teks rata kiri
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Pisahkan label dan nilai
                      children: [
                        Text(
                          'Status:',
                          style: TextStyle(
                            fontSize: hp * 0.015,
                            color: Colors.black,
                            // Beri cetak tebal pada label
                          ),
                        ),
                        Text(
                          'Siaga',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 255, 103, 14),
                            fontWeight: FontWeight.bold,
                            fontSize: hp * 0.015,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5), // Memberi jarak antara baris
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Pisahkan label dan nilai
                      children: [
                        Text(
                          'Ketinggian Air:',
                          style: TextStyle(
                            fontSize: hp * 0.015,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '120 cm',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 202, 27, 27),
                            fontWeight: FontWeight.bold,
                            fontSize: hp * 0.015,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Pisahkan label dan nilai
                      children: [
                        Text(
                          'Curah Hujan:',
                          style: TextStyle(
                            fontSize: hp * 0.015,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '5 mm',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 46, 185, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: hp * 0.015,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Pisahkan label dan nilai
                      children: [
                        Text(
                          'Kecepatan Angin:',
                          style: TextStyle(
                            fontSize: hp * 0.015,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '7 km/h',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 46, 185, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: hp * 0.015,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
