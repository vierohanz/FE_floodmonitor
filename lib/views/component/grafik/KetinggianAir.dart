import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class KetinggianAir extends StatelessWidget {
  const KetinggianAir({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue, // ganti dengan kprimarySecond jika ada
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: Text(
              'Ketinggian Air',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          AspectRatio(
            aspectRatio: 2,
            child: LineChart(
              LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 50),
                      FlSpot(1, 80),
                      FlSpot(2, 90),
                      FlSpot(3, 100),
                      FlSpot(4, 90),
                      FlSpot(5, 90),
                      FlSpot(6, 150),
                      FlSpot(7, 80),
                      FlSpot(8, 70),
                    ],
                    color: Colors.red,
                    gradient: LinearGradient(colors: [
                      Colors.lightBlueAccent,
                      Colors.purpleAccent,
                      Colors.red,
                    ]),
                    isCurved: false,
                    barWidth: 1,
                  ),
                ],
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 20,
                      getTitlesWidget: (value, meta) {
                        switch (value.toInt()) {
                          case 0:
                            return Text('24', style: TextStyle(fontSize: 13));
                          case 1:
                            return Text('25', style: TextStyle(fontSize: 13));
                          case 2:
                            return Text('26', style: TextStyle(fontSize: 13));
                          case 3:
                            return Text('27', style: TextStyle(fontSize: 13));
                          case 4:
                            return Text('28', style: TextStyle(fontSize: 13));
                          case 5:
                            return Text('29', style: TextStyle(fontSize: 13));
                          case 6:
                            return Text('30', style: TextStyle(fontSize: 13));
                          case 7:
                            return Text('31', style: TextStyle(fontSize: 13));
                          case 8:
                            return Text('01', style: TextStyle(fontSize: 13));
                        }
                        return Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        return Text(value.toStringAsFixed(0),
                            style: TextStyle(fontSize: 12));
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      reservedSize: 10,
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(
                      reservedSize: 10,
                    ),
                  ),
                ),
                gridData: FlGridData(show: true),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.black, width: 1),
                ),
                minX: 0,
                maxX: 8,
                minY: 50,
                maxY: 200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
