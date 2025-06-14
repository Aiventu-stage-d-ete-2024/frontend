import 'package:flutter/material.dart';
import '../../screens/pages/SplashScreen.dart';
import '../../screens/pages/asset_page.dart';
import '../../screens/pages/counter_page.dart';
import '../../screens/pages/home_page.dart';
import '../../screens/pages/mr_page.dart';
import '../../screens/pages/signup_page.dart';
import '../../screens/pages/notifications_page.dart';
import '../../screens/pages/signin_page.dart';

Map<String, Widget Function(BuildContext)> routes= {
   '/assets': (context) => const AssetPage(),
        '/maintenancerequests': (context) => const MaintenancePage(),
        '/counters': (context) => const CounterPage(),
        '/home': (context) => const MyHomePage(title: 'Finance & Operations'),
        '/signup': (context) => const SignupPage(),
        '/lauch': (context) => const SplashScreen(),
        '/notifications': (context) => const NotificationsPage(),
        '/signin': (context) => const SigninPage(),
};