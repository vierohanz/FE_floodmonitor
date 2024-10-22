import 'package:flutter/material.dart';

class WaterLevelCard extends StatelessWidget {
  final double currentHeight;
  final double predictedHeight;

  // Constructor untuk menerima data saat dipanggil
  WaterLevelCard({
    required this.currentHeight,
    required this.predictedHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(60),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 0.5,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${currentHeight}cm', // Menampilkan ketinggian air
                style: TextStyle(
                  fontFamily: 'NunitoSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              Text(
                'Ketinggian Air',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'NunitoSans',
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${predictedHeight}cm', // Menampilkan prediksi ketinggian air
                style: TextStyle(
                  fontFamily: 'NunitoSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              Text(
                'Prediksi Ketinggian Air',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'NunitoSans',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
