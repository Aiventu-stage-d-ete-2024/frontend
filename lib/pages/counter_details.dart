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
  Map<String, dynamic> _counterDetails = {};
  
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
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  counterAppBarBody(context, isCounterDetailsPage: true, counterDetails: _counterDetails, AssetID: widget.AssetID),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Counter Details',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 16.0),
                       // _buildDetailRow('Counter ID', _counterDetails['CounterID']),
                        _buildDetailRow('Asset', _counterDetails['AssetName']),
                        _buildDetailRow('Functional Location', _counterDetails['FunctionalLocation']),
                        _buildDetailRow('Counter Name', _counterDetails['Counter']),
                        _buildDetailRow('Counter Reset', _counterDetails['CounterReset']),
                        _buildDetailRow('Registered Date', _counterDetails['Registered']),
                        _buildDetailRow('Value', _counterDetails['Value']),
                        _buildDetailRow('Unit', _counterDetails['Unit']),
                        _buildDetailRow('Aggregated Value', _counterDetails['AggregatedValue']),
                        _buildDetailRow('Totals', _counterDetails['Totals']),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildDetailRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value?.toString() ?? '------------'),
        ],
      ),
    );
  }
}