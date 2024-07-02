import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 98.0,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF041431),
              ),
              child: const Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(10.0),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            title: const Text('Assets'),
            onTap: () {
              Navigator.pop(context); 
              Navigator.pushReplacementNamed(context, '/assets'); 
            },
          ),
          ListTile(
            title: const Text('Maintenance Requests'),
            onTap: () {
              Navigator.pop(context); 
              Navigator.pushReplacementNamed(context, '/maintenancerequests');
            },
          ),
        ],
      ),
    );
  }
}
