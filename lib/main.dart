
import 'package:flutter/material.dart';
import 'package:google/screens/phone_login_screen.dart';

void main() {
  runApp(const FloodAlertApp());
}

class FloodAlertApp extends StatelessWidget {
  const FloodAlertApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'نظام التنبؤ الذكي للسيول',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Pacifico',
        useMaterial3: true,
      ),
      home: const PhoneLoginScreen(),
    );
  }
}