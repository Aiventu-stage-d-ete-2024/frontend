import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/asset_page.dart';
import 'pages/SplashScreen.dart';
import 'pages/mr_page.dart';
import 'pages/signup_page.dart';
import 'pages/counter_page.dart';

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
      home: const SplashScreen(),
      routes: {
        '/assets': (context) => const AssetPage(),
        '/maintenancerequests': (context) => const MaintenancePage(),
        '/counters': (context) => const CounterPage(),
        '/home': (context) => const MyHomePage(title: 'Finance & Operations'),
        '/signup': (context) => const SignupPage(),
        '/lauch': (context) => const SplashScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
