import 'package:flutter/material.dart';
import '../pages/home_page.dart';

Widget appBarBody(BuildContext context) {
  return Container(
    color: Colors.white,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Finance and Operations')),
              (Route<dynamic> route) => false,
            );
          },
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
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add, color: Color(0xFF3665DB)),
          padding: EdgeInsets.zero,
        ),
        const Spacer(),
        TextButton.icon(
          onPressed: () {},
          label: const Text(
            'Counters',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          style: ButtonStyle(
            padding: WidgetStateProperty.all(EdgeInsets.zero),
          ),
        ),
        const Spacer(),
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
