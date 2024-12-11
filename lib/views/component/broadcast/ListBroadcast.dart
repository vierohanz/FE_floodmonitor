import 'package:flutter/material.dart';
import 'package:flood_monitor/utils/apiService.dart';

class Listbroadcast extends StatefulWidget {
  final int selectedDeviceId; // Tambahkan properti ini
  const Listbroadcast({Key? key, required this.selectedDeviceId})
      : super(key: key);

  @override
  _ListbroadcastState createState() => _ListbroadcastState();
}

class _ListbroadcastState extends State<Listbroadcast> {
  late Future<List<Map<String, dynamic>>> _broadcastData;

  @override
  void initState() {
    super.initState();
    _broadcastData = ApiService.fetchDataBroadcast();
  }

  String _getLocationName(int deviceId) {
    switch (deviceId) {
      case 1:
        return "Klego";
      case 2:
        return "Yosorejo";
      case 3:
        return "Kedungwuluh";
      case 4:
        return "Kertabesuki";
      default:
        return "Unknown Location";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _broadcastData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          // Filter data berdasarkan device_id
          final filteredData = widget.selectedDeviceId == 0
              ? snapshot.data!
              : snapshot.data!
                  .where((broadcast) =>
                      broadcast['device_id'] == widget.selectedDeviceId)
                  .toList();

          if (filteredData.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          return ListView.separated(
            itemCount: filteredData.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final broadcast = filteredData[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(
                    broadcast['name']?[0]?.toUpperCase() ?? '-',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(broadcast['name'] ?? 'Unknown'),
                subtitle: Text(
                    'Phone: ${broadcast['phone_number'] ?? "-"}\nNotes: ${broadcast['notes'] ?? "No notes"}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Hapus Broadcast'),
                          content: const Text(
                              'Apakah Anda yakin ingin menghapus item ini?'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Batal'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Hapus'),
                              onPressed: () {
                                setState(() {
                                  filteredData.removeAt(index);
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                onTap: () {
                  final location = _getLocationName(broadcast['device_id']);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Location: $location'),
                    ),
                  );
                },
              );
            },
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
