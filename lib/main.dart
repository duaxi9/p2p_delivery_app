import 'package:flutter/material.dart';
import 'package:p2p_delivery_app/home_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LinkAir',
      theme: ThemeData(
        primaryColor: const Color(0xFFB8960A),
      ),
      home: const HomeScreen(),
    );
  }
}