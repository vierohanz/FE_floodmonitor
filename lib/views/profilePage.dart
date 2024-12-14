import 'package:flood_monitor/controllers/statusController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusTerakhirView extends StatelessWidget {
  final StatusController statusC = Get.put(StatusController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ValueListenableBuilder<Map<String, dynamic>>(
        valueListenable: statusC.regencyNotifier,
        builder: (context, regency, child) {
          return Column(
            children: [
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: statusC.getFilteredData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      final filteredData = snapshot.data!;
                      if (filteredData.isNotEmpty) {
                        final result =
                            statusC.getComparisonResult(filteredData);

                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Display status cards here as you have
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "Hasil Perbandingan Status: $result",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const Center(child: Text('No data available'));
                      }
                    } else {
                      return const Center(child: Text('No data available'));
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
