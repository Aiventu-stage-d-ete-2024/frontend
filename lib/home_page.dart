import 'package:flutter/material.dart';
import 'widgets/app_bar_body.dart';
import 'widgets/assets.dart';
import 'widgets/maintenancerequests.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF041431),
        title: const Text(
          'Finance and Operations',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'USMF',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications, color: Colors.white),
            padding: EdgeInsets.zero,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.supervised_user_circle_rounded, color: Colors.white),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            appBarBody(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'All assets',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 30,
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Filter',
                            prefixIcon: Icon(Icons.search),
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  AssetTable(),
                  SizedBox(height: 16.0),
                  Text(
                    'All maintenance requests',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 8.0),
                  MaintenanceRequestsTable(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
