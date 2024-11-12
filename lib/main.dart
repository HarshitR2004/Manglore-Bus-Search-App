import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const BusRoutesApp());
}

class BusRoutesApp extends StatelessWidget {
  const BusRoutesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mangalore Bus Routes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,

      ),
      home: const HomeScreen(),
    );
  }
}

