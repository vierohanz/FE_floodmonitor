import 'package:flood_monitor/views/component/broadcast/ListBroadcast.dart';
import 'package:flutter/material.dart';

class messagePage extends StatelessWidget {
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFEBF0F7),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Container(
          width: wp,
          padding: EdgeInsets.only(top: 12, right: 22, left: 22, bottom: 10),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: hp * 0.02),
                child: Column(
                  children: [
                    Container(
                      width: wp,
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(13),
                          topRight: Radius.circular(13),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Daftar Broadcast",
                            style: TextStyle(
                              letterSpacing: 1,
                              fontFamily: "NunitoSans",
                              fontSize: wp * 0.045,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add, color: Colors.white),
                            onPressed: () {
                              // Tambahkan logika ketika tombol "+" ditekan
                              print("Tombol tambah ditekan");
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 14, right: 14, left: 14, bottom: 14),
                      width: wp,
                      height: hp * 0.65,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            offset: Offset(4.0, 4.0),
                            blurRadius: 5.0,
                            spreadRadius: 1.0,
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                      ),
                      child: Listbroadcast(),
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
