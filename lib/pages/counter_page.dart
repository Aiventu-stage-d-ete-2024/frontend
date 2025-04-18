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

  @override
  void initState() {
    super.initState();
    _fetchCounters();
  }

  Future<void> _fetchCounters() async {
    if (widget.assetId == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final url = Uri.parse('${baseUrl}counters/Asset/${widget.assetId}');

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
                      counterAppBarBody(context, isCounterDetailsPage: false, AssetID: widget.assetId!),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Counters for Asset ${widget.assetId}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const SizedBox(height: 16.0),
                            CountersTable(counters: _counters, AssetID: widget.assetId!),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
