import 'package:flutter/material.dart';
import '../pages/counter_form.dart';
import '../pages/counter_page.dart';
import '../pages/home_page.dart';
import '../baseURL.dart';
import 'package:http/http.dart' as http;

// Function to delete a counter
Future<void> deleteCounter(String counterId) async {
  final url = Uri.parse('${baseUrl}counters/$counterId');
  final response = await http.delete(
    url,
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to delete counter: ${response.body}');
  }
}

// Widget for AppBar actions in Counter pages
Widget counterAppBarBody(
  BuildContext context, {
  required bool isCounterDetailsPage,
  Map<String, dynamic>? counterDetails,
}) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Back Button
        IconButton(
          onPressed: () {
            if (isCounterDetailsPage) {
              // From Details page -> Go back to Counter List page
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const CounterPage()),
                (Route<dynamic> route) => false,
              );
            } else {
              // From Counter List page -> Go back to Home page
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyHomePage(title: "Finance & Operations"),
                ),
                (Route<dynamic> route) => false,
              );
            }
          },
          icon: const Icon(Icons.arrow_back, color: Color(0xFF3665DB)),
          padding: EdgeInsets.zero,
        ),

        // Edit Button (Details page only)
        if (isCounterDetailsPage && counterDetails != null)
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => CounterForm(
                    isUpdate: true,
                    counterDetails: counterDetails,
                  ),
                ),
                (Route<dynamic> route) => false,
              );
            },
            icon: const Icon(Icons.edit, color: Color(0xFF3665DB)),
            padding: EdgeInsets.zero,
          ),

        // Add Button (List page only)
        if (!isCounterDetailsPage)
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const CounterForm()),
                (Route<dynamic> route) => false,
              );
            },
            icon: const Icon(Icons.add, color: Color(0xFF3665DB)),
            padding: EdgeInsets.zero,
          ),

        // Delete Button (Details page only)
        if (isCounterDetailsPage && counterDetails != null)
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
                    content: const Text('Are you sure you want to delete this counter?'),
                    backgroundColor: Colors.white,
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel', style: TextStyle(color: Color(0xFF3665DB))),
                      ),
                      TextButton(
                        onPressed: () async {
                          try {
                            await deleteCounter(counterDetails['_id']);
                            Navigator.of(context).pop();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const CounterPage()),
                              (Route<dynamic> route) => false,
                            );
                          } catch (e) {
                            print('Error deleting counter: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed to delete counter: $e')),
                            );
                          }
                        },
                        child: const Text('Delete', style: TextStyle(color: Color(0xFF3665DB))),
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
    ),
  );
}