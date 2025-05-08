import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/main_app_bar.dart';
import '../baseUrl.dart';
import '../widgets/mr_table.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/mr_app_bar_body.dart';

class MaintenancePage extends StatefulWidget {
  const MaintenancePage({super.key});

  @override
  _MaintenancePageState createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage> {
  List<dynamic> _maintenanceRequests = [];
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();
  final Duration debounceDuration = const Duration(milliseconds: 300);
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _fetchMaintenanceRequests('');
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(debounceDuration, () {
      _fetchMaintenanceRequests(_searchController.text);
    });
  }

  Future<void> _fetchMaintenanceRequests(String query) async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('${baseUrl}maintenanceRequests/search?query=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _maintenanceRequests = data;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load maintenance requests');
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      drawer: const DrawerWidget(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            mrAppBarBody(context, isMRDetailsPage: false),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'All maintenance requests',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 30,
                        child: TextField(
                          controller: _searchController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'Filter',
                            prefixIcon: const Icon(Icons.search),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Color(0xFF3665DB), width: 2.0),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  MaintenanceRequestsTable(
                    maintenanceRequests: _maintenanceRequests,
                    isLoading: _isLoading,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
