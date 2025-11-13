import 'package:eventify/views/login/login_page.dart';
import 'package:flutter/material.dart';

// This is the entry point of the application

void main() {
  runApp(const MyApp());
}

// Main Widget

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      home: LoginPage(),
    );
  }
}

