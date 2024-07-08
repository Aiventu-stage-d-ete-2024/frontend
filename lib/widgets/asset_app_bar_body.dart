import 'package:flutter/material.dart';
import 'package:test/pages/Asset_form.dart';
import '../pages/home_page.dart';

Widget assetAppBarBody(BuildContext context) {
  return Container(
    color: Colors.white,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage(title: "Finance & Operations",)),
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
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const AssetForm()),
              (Route<dynamic> route) => false,
            );
          },
          icon: const Icon(Icons.add, color: Color(0xFF3665DB)),
          padding: EdgeInsets.zero,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.delete, color: Color(0xFF3665DB)),
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
