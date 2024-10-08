import 'package:audio_player/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home.dart'; // Import Home

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => const Home()); // Navigasi ke Home setelah 3 detik
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor, // Sesuaikan warna sesuai tema aplikasi
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ganti dengan gambar
            Image.asset(
              'assets/images/logoNZ.png',
              filterQuality: FilterQuality.high, // Path ke file gambar
              width: 300, // Sesuaikan ukuran gambar
              height: 300,
            ),
          ],
        ),
      ),
    );
  }
}
