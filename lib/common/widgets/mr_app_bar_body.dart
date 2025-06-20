import 'package:flutter/material.dart';
import '../../screens/pages/mr_form.dart';
import '../../screens/pages/mr_page.dart';
import '../../screens/pages/home_page.dart';
import '../../core/utils/constant.dart';
import 'package:http/http.dart' as http;

Future<void> deleteRequest(String requestId) async {
  final url = Uri.parse('${baseUrl}maintenanceRequests/$requestId');
  final response = await http.delete(
    url,
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
  } else {
    throw Exception('Failed to delete request: ${response.body}');
  }
}

Widget mrAppBarBody(
  BuildContext context, {
  required bool isMRDetailsPage,
  Map<String, dynamic>? mrDetails,
}) {
  return Container(
    color: Colors.white,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            if (isMRDetailsPage) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const MaintenancePage()),
                (Route<dynamic> route) => false,
              );
            } else {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const MyHomePage(title: "Finance & Operations")),
                (Route<dynamic> route) => false,
              );
            }
          },
          icon: const Icon(Icons.arrow_back, color: Color(0xFF3665DB)),
          padding: EdgeInsets.zero,
        ),
        if (isMRDetailsPage && mrDetails != null) ...[
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MaintenanceRequestForm(
                    isUpdate: true,
                    mrDetails: mrDetails,
                  ),
                ),
                (Route<dynamic> route) => false,
              );
            },
            icon: const Icon(Icons.edit, color: Color(0xFF3665DB)),
            padding: EdgeInsets.zero,
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      'Confirm Deletion',
                      style: TextStyle(color: Color(0xFF3665DB)),
                    ),
                    content: const Text(
                        'Are you sure you want to delete this maintenance request?'),
                    backgroundColor: Colors.white,
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel',
                            style: TextStyle(color: Color(0xFF3665DB))),
                      ),
                      TextButton(
                        onPressed: () async {
                          try {
                            await deleteRequest(mrDetails['_id']);
                            Navigator.of(context).pop();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MaintenancePage()),
                              (Route<dynamic> route) => false,
                            );
                          } catch (e) {
                            print('Error deleting request: $e');
                          }
                        },
                        child: const Text('Delete',
                            style: TextStyle(color: Color(0xFF3665DB))),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.delete, color: Color(0xFF3665DB)),
            padding: EdgeInsets.zero,
          ),
        ],
        if (!isMRDetailsPage)
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const MaintenanceRequestForm(),
                ),
                (Route<dynamic> route) => false,
              );
            },
            icon: const Icon(Icons.add, color: Color(0xFF3665DB)),
            padding: EdgeInsets.zero,
          ),
      ],
    ),
  );
}
