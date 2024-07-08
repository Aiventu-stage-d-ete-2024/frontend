import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import '../widgets/main_app_bar.dart';
import '../baseUrl.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/mr_app_bar_body.dart';

class MRDetailsPage extends StatefulWidget {
  final String RequestID;

  const MRDetailsPage({required this.RequestID});

  @override
  _MRDetailsPageState createState() => _MRDetailsPageState();
}

class _MRDetailsPageState extends State<MRDetailsPage> {
  Map<String, dynamic>? _mrDetails;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMRDetails();
  }

  Future<void> _fetchMRDetails() async {
    final url = Uri.parse('${baseUrl}maintenancerequests/${widget.RequestID}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _mrDetails = data;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load maintenance request details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      drawer: DrawerWidget(),
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                mrAppBarBody(context),
                Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          Center(
                            child: Text(
                              'Maintenance Request Details',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3665DB),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                          _buildDetailRow('Request ID', _mrDetails!['RequestID']),
                          _buildDetailRow('Request Type', _mrDetails!['RequestType']),
                          _buildDetailRow('Description', _mrDetails!['Description']),
                          _buildDetailRow('Service Level', _mrDetails!['ServiceLevel']),
                          _buildDetailRow('Functional Location', _mrDetails!['FunctionalLocation']),
                          _buildDetailRow('Asset', _mrDetails!['Asset']),
                          _buildDetailRow('Asset Verified', _mrDetails!['AssetVerified']),
                          _buildDetailRow('Maintenance Job Type', _mrDetails!['JobType']),
                          _buildDetailRow('Maintenance Job Type Variant', _mrDetails!['JobVariant']),
                          _buildDetailRow('Trade', _mrDetails!['JobTrade']),
                          _buildDetailRow('Actual Start', _formatActualStart(_mrDetails!['ActualStart'])),
                          _buildDetailRow('Started By', _mrDetails!['StartedByWorker']),
                          _buildDetailRow('Responsible Group', _mrDetails!['ResponsibleWorkerGroup']),
                          _buildDetailRow('Responsible', _mrDetails!['ResponsibleWorker']),
                          _buildDetailRow('Current Lifecycle State', _mrDetails!['CurrentLifecycleState']),
                          _buildDetailRow('Number Of Faults', _mrDetails!['NumberOfFaults']),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    ],
                  ),
                ),
                ),
              ],
            ),
    );
  }

  Widget _buildDetailRow(String label, dynamic value) {
    if (value == null || value.toString().isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '------------',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      );
    }

    String displayValue = value.toString();

    if (label == 'Asset Verified') {
      displayValue = value ? '✔' : '❌';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 4),
          Text(
            displayValue,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  String _formatActualStart(dynamic value) {
    if (value == null || value.toString().isEmpty) {
      return '------------';
    }
    try {
      DateTime dateTime = DateTime.parse(value);
      String formattedDateTime = DateFormat('M/d/yyyy h:mm:ss a').format(dateTime.toLocal());
      return formattedDateTime;
    } catch (e) {
      return '------------';
    }
  }
}
