import 'package:flutter/material.dart';

class StatusTerakhir1Tab extends StatelessWidget {
  final Map<String, dynamic> data; // Data yang diterima dari StatusParent

  const StatusTerakhir1Tab({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;

    // Menentukan format tanggal dari data yang diterima
    final createdAt = DateTime.parse(data['created_at']);
    final formattedDate =
        '${createdAt.day}-${createdAt.month}-${createdAt.year} ${createdAt.hour}:${createdAt.minute}';

    String deviceName = data['device_name']; // Misalnya "DEVICE-Klego"
    String cleanedDeviceName =
        deviceName.replaceAll('DEVICE-', ''); // Hasilnya "Klego"

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
            'Titik Pantau $cleanedDeviceName ($formattedDate)',
            style: TextStyle(
              fontSize: hp * 0.014,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 10),
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
                          ),
                        ),
                        Text(
                          data['status'] ??
                              'N/A', // Menampilkan status dari data
                          style: TextStyle(
                            color: const Color.fromARGB(255, 255, 103, 14),
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
                          'Ketinggian Air:',
                          style: TextStyle(
                            fontSize: hp * 0.015,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '${data['water_level']} cm',
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
                          '${data['rainfall']} mm',
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
                          '${data['wind_speed']} km/h',
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
