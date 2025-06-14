import 'package:flutter/material.dart';
import 'core/navigation/routes.dart';
import 'screens/pages/SplashScreen.dart';
import 'features/services/socketService.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SocketService.initialize();
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
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
