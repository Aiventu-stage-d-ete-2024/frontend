import 'package:flutter/material.dart';
import 'package:test/pages/signin_page.dart';
import 'package:test/pages/notifications_page.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF041431),
      automaticallyImplyLeading: false,
      title: GestureDetector(
        onTap: () {
          Scaffold.of(context).openDrawer();
        },
        child: const Text(
          'Finance & Operations',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        Container(
          margin: EdgeInsets.zero,
          child: TextButton(
            onPressed: () {},
            child: const Text(
              'USMF',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.zero,
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationsPage()),
              );
            },
            icon: const Icon(Icons.notifications, color: Colors.white),
            padding: EdgeInsets.zero,
          ),
        ),
        Container(
          margin: EdgeInsets.zero,
          child: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const SigninPage()),
                    (Route<dynamic> route) => false,
                  );
            },
            //icon: const Icon(Icons.supervised_user_circle_rounded, color: Colors.white),
            icon: const Icon(Icons.exit_to_app_rounded, color: Colors.white),
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }
}