import 'package:flutter/material.dart';
import 'package:flood_monitor/views/component/status/StatusTerakhir_1.dart';
import 'package:flood_monitor/views/component/status/StatusTerakhir_2.dart';
import 'package:flood_monitor/controllers/StatusController.dart';

class StatusParent extends StatefulWidget {
  const StatusParent({super.key});

  @override
  _StatusParentState createState() => _StatusParentState();
}

class _StatusParentState extends State<StatusParent> {
  late StatusController statusController;

  @override
  void initState() {
    super.initState();
    statusController = StatusController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ValueListenableBuilder<Map<String, dynamic>>(
        valueListenable: statusController.regencyNotifier,
        builder: (context, regency, child) {
          // Listener untuk regency changes
          return Column(
            children: [
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: statusController.getFilteredData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      final filteredData = snapshot.data!;
                      if (filteredData.isNotEmpty) {
                        final statusTerakhir1Data = statusController
                            .getStatusData(filteredData, [1, 3]);
                        final statusTerakhir2Data = statusController
                            .getStatusData(filteredData, [2, 4]);

                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              if (statusTerakhir1Data != null)
                                StatusTerakhir1Tab(data: statusTerakhir1Data),
                              if (statusTerakhir2Data != null)
                                StatusTerakhir2Tab(data: statusTerakhir2Data),
                            ],
                          ),
                        );
                      } else {
                        return Center(child: Text('Fetching data...'));
                      }
                    } else {
                      return Center(child: Text('No data available'));
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
