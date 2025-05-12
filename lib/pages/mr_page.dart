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
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const MainAppBar(),
      drawer: const DrawerWidget(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            mrAppBarBody(context, isMRDetailsPage: false),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 16.0),
                  const Center(
                    child: Text(
                      'All Maintenance Requests',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Color(0xFF3665DB),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: screenWidth,
                      height: 45,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                          hintText: 'Search for maintenance requests...',
                          prefixIcon:
                              Icon(Icons.search, color: Color(0xFF3665DB)),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: MaintenanceRequestsTable(
                        maintenanceRequests: _maintenanceRequests,
                        isLoading: _isLoading,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
