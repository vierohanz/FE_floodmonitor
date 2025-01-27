import 'package:flutter/material.dart';
import 'package:flood_monitor/views/component/status/StatusTerakhir_1.dart';
import 'package:flood_monitor/views/component/status/StatusTerakhir_2.dart';
import 'package:flood_monitor/controllers/StatusController.dart';
import 'package:shimmer/shimmer.dart';

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

  Widget _buildShimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder untuk elemen header (kotak panjang di atas)
            Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), // Sudut kiri atas tumpul
                  topRight: Radius.circular(5), // Sudut kanan atas tumpul
                  bottomLeft: Radius.circular(0), // Sudut kiri bawah tajam
                  bottomRight: Radius.circular(0), // Sudut kanan bawah tajam
                ),
              ),
              width: double.infinity,
              height: 34.0,
              margin: const EdgeInsets.only(bottom: 16.0),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Placeholder untuk kotak besar di kiri bawah
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0), // Radius sudut
                    color: Colors.grey,
                  ),
                  width: 100.0,
                  height: 100.0,
                  margin: const EdgeInsets.only(right: 16.0),
                ),
                // Placeholder untuk elemen di kanan
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Placeholder untuk elemen kanan atas (kecil)
                          Container(
                            width: 50.0,
                            height: 16.0,
                            color: Colors.grey,
                          ),
                          Container(
                            width: 50.0,
                            height: 16.0,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      // Placeholder untuk elemen panjang di tengah
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Placeholder untuk elemen kanan atas (kecil)
                          Container(
                            width: 85.0,
                            height: 16.0,
                            color: Colors.grey,
                          ),
                          Container(
                            width: 35.0,
                            height: 16.0,
                            color: Colors.grey,
                          ),
                        ],
                      ),

                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Placeholder untuk elemen kanan bawah
                          Container(
                            width: 80.0,
                            height: 16.0,
                            color: Colors.grey,
                          ),
                          Container(
                            width: 40.0,
                            height: 16.0,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 90.0,
                            height: 16.0,
                            color: Colors.grey,
                          ),
                          Container(
                            width: 30.0,
                            height: 16.0,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 26,
            ),

            // start
            Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), // Sudut kiri atas tumpul
                  topRight: Radius.circular(5), // Sudut kanan atas tumpul
                  bottomLeft: Radius.circular(0), // Sudut kiri bawah tajam
                  bottomRight: Radius.circular(0), // Sudut kanan bawah tajam
                ),
              ),
              width: double.infinity,
              height: 34.0,
              margin: const EdgeInsets.only(bottom: 16.0),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Placeholder untuk kotak besar di kiri bawah
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0), // Radius sudut
                    color: Colors.grey,
                  ),
                  width: 100.0,
                  height: 100.0,
                  margin: const EdgeInsets.only(right: 16.0),
                ),
                // Placeholder untuk elemen di kanan
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Placeholder untuk elemen kanan atas (kecil)
                          Container(
                            width: 50.0,
                            height: 16.0,
                            color: Colors.grey,
                          ),
                          Container(
                            width: 50.0,
                            height: 16.0,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      // Placeholder untuk elemen panjang di tengah
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Placeholder untuk elemen kanan atas (kecil)
                          Container(
                            width: 85.0,
                            height: 16.0,
                            color: Colors.grey,
                          ),
                          Container(
                            width: 35.0,
                            height: 16.0,
                            color: Colors.grey,
                          ),
                        ],
                      ),

                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Placeholder untuk elemen kanan bawah
                          Container(
                            width: 80.0,
                            height: 16.0,
                            color: Colors.grey,
                          ),
                          Container(
                            width: 40.0,
                            height: 16.0,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 90.0,
                            height: 16.0,
                            color: Colors.grey,
                          ),
                          Container(
                            width: 30.0,
                            height: 16.0,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // end
          ],
        ),
      ),
    );
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
                      return _buildShimmerPlaceholder();
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
                        return Center(
                          child: Text('No data available'),
                        );
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
