import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 
import '../pages/Asset_form.dart';
import '../pages/home_page.dart';
import '../pages/asset_page.dart';
import '../baseURL.dart';

Future<void> deleteAsset(String assetId) async {
  final url = Uri.parse('${baseUrl}assets/$assetId');
  final response = await http.delete(
    url,
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
  } else {
    throw Exception('Failed to delete asset: ${response.body}');
  }
}

Widget assetAppBarBody(BuildContext context, {required bool isAssetDetailsPage, Map<String, dynamic>? assetDetails}) {
  return Container(
    color: Colors.white,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            if (isAssetDetailsPage) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const AssetPage()),
                (Route<dynamic> route) => false,
              );
            } else {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage(title: "Finance & Operations")),
                (Route<dynamic> route) => false,
              );
            }
          },
          icon: const Icon(Icons.arrow_back, color: Color(0xFF3665DB)),
          padding: EdgeInsets.zero,
        ),
        IconButton(
          onPressed: () {
            if (isAssetDetailsPage && assetDetails != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AssetForm(
                    isUpdate: true,
                    assetDetails: assetDetails,
                  ),
                ),
              );
            }
          },
          icon: const Icon(Icons.edit, color: Color(0xFF3665DB)),
          padding: EdgeInsets.zero,
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AssetForm(),
              ),
            );
          },
          icon: const Icon(Icons.add, color: Color(0xFF3665DB)),
          padding: EdgeInsets.zero,
        ),
        IconButton(
  onPressed: () {
    if (isAssetDetailsPage && assetDetails != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Confirm Deletion',
              style: TextStyle(color: Color(0xFF3665DB)),
            ),
            content: const Text('Are you sure you want to delete this asset?'),
            backgroundColor: Colors.white,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Color(0xFF3665DB)),
                ),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    await deleteAsset(assetDetails['_id']);
                    Navigator.of(context).pop();

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const AssetPage()),
                      (Route<dynamic> route) => false,
                    );
                  } catch (e) {
                    print('Error deleting asset: $e');
                  }
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Color(0xFF3665DB)),
                ),
              ),
            ],
          );
        },
      );
    }
  },
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
