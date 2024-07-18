import 'package:flutter/material.dart';
import 'package:test/pages/signin_page.dart';
import 'pages/home_page.dart';
import 'pages/asset_page.dart';
import 'pages/mr_page.dart';
import 'pages/signup_page.dart';

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
      home: const SigninPage(),
      routes: {
        '/assets': (context) => const AssetPage(),
        '/maintenancerequests': (context) => const MaintenancePage(),
        '/home': (context) => const MyHomePage(title: 'Finance & Operations'),
        '/signup': (context) => const SignupPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
