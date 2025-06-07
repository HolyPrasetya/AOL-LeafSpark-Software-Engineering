import 'package:flutter/material.dart';
import 'package:myapp/auth_wrapper.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  LinearGradient _backgroundGradient = const LinearGradient(
    colors: [Colors.white, Colors.white], // Gradien awal (putih)
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  void initState() {
    super.initState();

    // Mulai animasi setelah delay singkat
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _backgroundGradient = const LinearGradient(
          colors: [Color(0xffA0FFE3), Color(0xffD7E2E7)], // Gradien lightGreen
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      });
    });

    // ganti animasi ke background yang lain setelah delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _backgroundGradient = const LinearGradient(
          colors: [Color(0xffD7E2E7), Color(0xFFA0FFE3)], // Gradien green
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      });
    });

    // Navigasi ke halaman authwrapper setelah 3 detik
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AuthWrapper()));
    });
  }

  @override
  Widget build(BuildContext context) {
    // bikin animated container, supaya animasi bisa berjalan
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 1),
        decoration: BoxDecoration(gradient: _backgroundGradient),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ini adalah asset image logo leafspark
              Image.asset(
                'assets/image/LIGHT.png',
                width: 300,
                height: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
