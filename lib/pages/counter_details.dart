import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../baseURL.dart';
import '../widgets/main_app_bar.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/counter_app_bar_body.dart';

class CounterDetailsPage extends StatefulWidget {
  final String CounterID;
  final String AssetID;

  const CounterDetailsPage({super.key, required this.CounterID, required this.AssetID});

  @override
  _CounterDetailsPageState createState() => _CounterDetailsPageState();
}

class _CounterDetailsPageState extends State<CounterDetailsPage> {
  Map<String, dynamic>? _counterDetails;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCounterDetails();
  }

  Future<void> _fetchCounterDetails() async {
    final url = Uri.parse('${baseUrl}counters/counterid/${widget.CounterID}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _counterDetails = data;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load counter details');
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
          : _counterDetails == null
              ? const Center(child: Text('Counter details not found'))
              : Column(
                  children: [
                    counterAppBarBody(context, isCounterDetailsPage: true, counterDetails: _counterDetails!, AssetID: widget.AssetID),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(16),
                        children: [
                          const SizedBox(height: 16),
                          const Center(
                            child: Text(
                              'Counter Details',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3665DB),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildDetailCard(Icons.confirmation_number, 'Counter ID', _counterDetails!['CounterID']),
                          _buildDetailCard(Icons.inventory_2, 'Asset', _counterDetails!['AssetName']),
                          _buildDetailCard(Icons.location_on, 'Functional Location', _counterDetails!['FunctionalLocation']),
                          _buildDetailCard(Icons.countertops, 'Counter Name', _counterDetails!['Counter']),
                          _buildDetailCard(Icons.restart_alt, 'Counter Reset', _counterDetails!['CounterReset']),
                          _buildDetailCard(Icons.date_range, 'Registered Date', _counterDetails!['Registered']),
                          _buildDetailCard(Icons.numbers, 'Value', _counterDetails!['Value']),
                          _buildDetailCard(Icons.straighten, 'Unit', _counterDetails!['Unit']),
                          _buildDetailCard(Icons.stacked_line_chart, 'Aggregated Value', _counterDetails!['AggregatedValue']),
                          _buildDetailCard(Icons.calculate, 'Totals', _counterDetails!['Totals']),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _buildDetailCard(IconData icon, String title, dynamic value) {
    String displayValue = value == null || value.toString().isEmpty ? '------------' : value.toString();

    return Card(
      color: Colors.grey[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF3665DB)),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        subtitle: Text(
          displayValue,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
