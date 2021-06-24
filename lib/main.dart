import 'package:e_management/src/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

void main() {    
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: DashboardScreen(),
    );
  }
}
 