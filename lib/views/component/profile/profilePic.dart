import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class profilePic extends StatefulWidget {
  const profilePic({Key? key}) : super(key: key);

  @override
  _profilePicState createState() => _profilePicState();
}

class _profilePicState extends State<profilePic> {
  String? _imagePath; // Path gambar yang dipilih

  @override
  void initState() {
    super.initState();
    _loadImage(); // Muat gambar saat widget diinisialisasi
  }

  // Fungsi untuk memuat gambar dari SharedPreferences
  Future<void> _loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _imagePath = prefs.getString('profileImage');
    });
  }

  // Fungsi untuk menyimpan path gambar ke SharedPreferences
  Future<void> _saveImage(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profileImage', path);
  }

  // Fungsi untuk mengganti gambar menggunakan Image Picker
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
      await _saveImage(pickedFile.path); // Simpan path gambar
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          // Tampilkan gambar dari _imagePath, atau gambar default jika null
          CircleAvatar(
            backgroundImage: _imagePath != null
                ? FileImage(File(_imagePath!)) as ImageProvider
                : const NetworkImage(
                    "https://mm.feb.uncen.ac.id/wp-content/uploads/2016/01/tutor-8.jpg"),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.white),
                  ),
                  backgroundColor: const Color(0xFFF5F6F9),
                ),
                onPressed: _pickImage, // Panggil fungsi untuk memilih gambar
                child: const Icon(Icons.camera_alt, color: Colors.grey),
              ),
            ),
          )
        ],
      ),
    );
  }
}
