import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3)); // Delay selama 3 detik.
    Navigator.pushReplacementNamed(
        context, '/home'); // Ganti '/home' dengan route tujuan.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Sesuaikan warna latar belakang.
      body: Padding(
        padding: const EdgeInsets.only(right: 40, left: 40),
        child: Center(
          child: Image.asset(
              "assets/images/logo_MF.png"), // Menampilkan logo splash.
        ),
      ),
    );
  }
}
