import 'package:flutter/material.dart';
import 'package:coba1/admin/admin.dart';
import 'package:coba1/resepsionis/resepsionis.dart';
import 'login_page.dart';
import 'package:coba1/splash_screen.dart';
import 'admin/admin_login_page.dart'; // Pastikan file splash_screen.dart sudah ada
import 'user/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Wikusama Hotel',

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Mengarahkan ke SplashScreen saat aplikasi dibuka
      home: SplashScreen(),
      routes: {
        '/login': (context) => AdminLoginPage(),
        '/home': (context) => HomePage(),
        '/admin': (context) => Admin(),
        '/resepsionis': (context) => HomeResepsionis(),
      },
    );
  }
}
