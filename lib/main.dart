import 'package:flutter/material.dart';
import 'assets.dart';
import 'maintenancerequests.dart';

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
      debugShowCheckedModeBanner: false,
    );
  }
}

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
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications, color: Colors.white),
            padding: EdgeInsets.zero,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
            color: Colors.white,
            padding: EdgeInsets.zero,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.help),
            color: Colors.white,
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
      SizedBox(height: 8.0),
      Text(
        'Standard view',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
      ),
      SizedBox(height: 16.0),
      Row(
  children: [
    SizedBox(
      width: 200, 
      height: 40,
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Filter',
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
)
          ],
        ),
      ),
    );
  }

  Widget appBarBody() {
    return Container(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back, color: Color(0xFF3665DB)),
            padding: EdgeInsets.zero,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit, color: Color(0xFF3665DB)),
            padding: EdgeInsets.zero,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add, color: Color(0xFF3665DB)),
            padding: EdgeInsets.zero,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete, color: Color(0xFF3665DB)),
            padding: EdgeInsets.zero,
          ),
          TextButton.icon(
            onPressed: () {},
            label: const Text(
              'Asset',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            style: ButtonStyle(
              padding: WidgetStateProperty.all(EdgeInsets.zero),
            ),
          ),
          TextButton.icon(
            onPressed: () {},
            label: const Text(
              'General',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            style: ButtonStyle(
              padding: WidgetStateProperty.all(EdgeInsets.zero),
            ),
          ),
          TextButton.icon(
            onPressed: () {},
            label: const Text(
              'Options',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            style: ButtonStyle(
              padding: WidgetStateProperty.all(EdgeInsets.zero),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Color(0xFF3665DB)),
            padding: EdgeInsets.zero,
          ),
          IconButton(
                    onPressed: () {},
                    icon: SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset('assets/icons/powerapps.png'),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset('assets/icons/microsoftoffice.png'),
                    ),
                  ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.attachment, color: Color(0xFF3665DB)),
            padding: EdgeInsets.zero,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh, color: Color(0xFF3665DB)),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}