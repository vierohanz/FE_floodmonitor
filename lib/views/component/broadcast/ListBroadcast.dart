import 'package:flutter/material.dart';

class Listbroadcast extends StatelessWidget {
  Listbroadcast({super.key});

  // Data contoh kontak
  final List<Map<String, String>> kontakList = [
    {"nama": "Suko Tyas P", "nomor": "031931939193"},
    {"nama": "ST Pernanda", "nomor": "031931939193"},
    {"nama": "S. Tyas P.", "nomor": "031931939193"},
    {"nama": "Suko Tyas Pernanda", "nomor": "031931939193"},
    {"nama": "S. Tyas P.", "nomor": "031931939193"},
    {"nama": "Suko Tyas Pernanda", "nomor": "031931939193"},
    {"nama": "S. Tyas P.", "nomor": "031931939193"},
    {"nama": "Suko Tyas Pernanda", "nomor": "031931939193"},
    {"nama": "S. Tyas P.", "nomor": "031931939193"},
    {"nama": "Suko Tyas Pernanda", "nomor": "031931939193"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: kontakList.length,
          itemBuilder: (context, index) {
            final kontak = kontakList[index];
            return Card(
              color: const Color.fromARGB(255, 240, 240, 240),
              margin: EdgeInsets.symmetric(vertical: 5.0),
              child: ListTile(
                title: Text(kontak['nama']!),
                subtitle: Text('${kontak['nomor']}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // Logika hapus (bisa ditambahkan sesuai kebutuhan)
                    // Misalnya: tampilkan dialog konfirmasi
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Hapus Kontak'),
                          content: Text(
                              'Apakah Anda yakin ingin menghapus kontak ini?'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Batal'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Hapus'),
                              onPressed: () {
                                // Implementasi penghapusan data dari list
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
