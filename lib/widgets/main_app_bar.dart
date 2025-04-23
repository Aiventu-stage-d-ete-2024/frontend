import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/notifications_page.dart';
import '../services/socketService.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  _MainAppBarState createState() => _MainAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MainAppBarState extends State<MainAppBar> {
  int _unreadCount = 0;

  @override
  void initState() {
    super.initState();
    _loadUnreadCount();

    SocketService.onNewNotification((notification) async {
  //print("🔔 MainAppBar received notification: $notification");

  if (mounted) {
    setState(() {
      _unreadCount++;
    });
  }

  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('unreadCount', _unreadCount);
});

  }

  Future<void> _loadUnreadCount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _unreadCount = prefs.getInt('unreadCount') ?? 0;
    });
  }

  Future<void> _resetUnreadCount() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('unreadCount', 0);
  setState(() {
    _unreadCount = 0;
  });
}


  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF041431),
      automaticallyImplyLeading: false,
      title: GestureDetector(
        onTap: () => Scaffold.of(context).openDrawer(),
        child: const Text(
          'Finance & Operations',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text('USMF', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        Container(
          margin: const EdgeInsets.only(right: 8),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: () async {
  _resetUnreadCount(); 
  await Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const NotificationsPage()),
  );
},

                icon: const Icon(Icons.notifications, color: Colors.white),
              ),
              if (_unreadCount > 0)
                Positioned(
                  top: 8,
                  right: -2, 
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      '$_unreadCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/signin', (_) => false);
          },
          icon: const Icon(Icons.exit_to_app_rounded, color: Colors.white),
        ),
      ],
    );
  }
}
