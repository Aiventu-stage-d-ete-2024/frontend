import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/main_app_bar.dart';
import '../baseUrl.dart';
import '../widgets/counter_table.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/counter_app_bar_body.dart';

class CounterPage extends StatefulWidget {
  final String? assetId;

  const CounterPage({super.key, this.assetId});

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  List<dynamic> _counters = [];
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchCounters();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
      _fetchCounters();
    });
  }

  Future<void> _fetchCounters() async {
    if (widget.assetId == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final url = Uri.parse(
      '${baseUrl}counters/Asset/${widget.assetId}/search?query=$_searchQuery',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _counters = data;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        throw Exception('Failed to load counters');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      debugPrint('Error fetching counters: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error loading counters')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const MainAppBar(),
      drawer: const DrawerWidget(),
      backgroundColor: Colors.white,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : widget.assetId == null
              ? const Center(child: Text("No Asset ID provided."))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      counterAppBarBody(
                        context,
                        isCounterDetailsPage: false,
                        AssetID: widget.assetId!,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        //padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 16.0),
                            Center(
                              child: Text(
                                'Counters for Asset ${widget.assetId}',
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF3665DB),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: screenWidth,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
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
                                  decoration: InputDecoration(
                                    hintText: 'Search counters...',
                                    prefixIcon: const Icon(Icons.search,
                                        color: Color(0xFF3665DB)),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            SizedBox(
                              width: screenWidth,
                              child: CountersTable(
                                counters: _counters,
                                AssetID: widget.assetId!,
                              ),
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
