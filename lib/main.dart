import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/asset_page.dart';
import 'pages/mr_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance and Operations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Finance and Operations'),
      routes: {
        '/assets': (context) => const AssetPage(),
        '/maintenancerequests': (context) => const MaintenancePage(),
        '/home': (context) => const MyHomePage(title: 'Finance & Operations'),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
