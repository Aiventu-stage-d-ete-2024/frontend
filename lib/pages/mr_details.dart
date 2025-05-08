import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/main_app_bar.dart';
import '../baseUrl.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/mr_app_bar_body.dart';

class MRDetailsPage extends StatefulWidget {
  final String RequestID;

  const MRDetailsPage({super.key, required this.RequestID});

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
      appBar: const MainAppBar(),
      drawer: const DrawerWidget(),
      backgroundColor: Colors.white,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _mrDetails == null
              ? const Center(child: Text('Maintenance request details not found'))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    mrAppBarBody(context, isMRDetailsPage: true, mrDetails: _mrDetails),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            const Center(
                              child: Text(
                                'Maintenance Request Details',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF3665DB),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildDetailCard(Icons.confirmation_number, 'Request ID', _mrDetails!['RequestID']),
                                  _buildDetailCard(Icons.category, 'Request Type', _mrDetails!['RequestType']),
                                  _buildDetailCard(Icons.description, 'Description', _mrDetails!['Description']),
                                  _buildDetailCard(Icons.assessment, 'Service Level', _mrDetails!['ServiceLevel']),
                                  _buildDetailCard(Icons.location_on, 'Functional Location', _mrDetails!['FunctionalLocation']),
                                  _buildDetailCard(Icons.precision_manufacturing, 'Asset', _mrDetails!['Asset']),
                                  //_buildDetailCard(Icons.verified, 'Asset Verified', _formatAssetVerified(_mrDetails!['AssetVerified'])),
                                  _buildDetailCard(Icons.build, 'Maintenance Job Type', _mrDetails!['JobType']),
                                  _buildDetailCard(Icons.settings_applications, 'Maintenance Job Type Variant', _mrDetails!['JobVariant']),
                                  _buildDetailCard(Icons.handyman, 'Trade', _mrDetails!['JobTrade']),
                                  _buildDetailCard(Icons.timer, 'Actual Start', _mrDetails!['ActualStart']),
                                  _buildDetailCard(Icons.person, 'Started By', _mrDetails!['StartedByWorker']),
                                  _buildDetailCard(Icons.group, 'Responsible Group', _mrDetails!['ResponsibleWorkerGroup']),
                                  _buildDetailCard(Icons.person_pin, 'Responsible Worker', _mrDetails!['ResponsibleWorker']),
                                  _buildDetailCard(Icons.work, 'Work Order', _mrDetails!['WorkOrder']),
                                  _buildDetailCard(Icons.timeline, 'Current Lifecycle State', _mrDetails!['CurrentLifecycleState']),
                                  _buildDetailCard(Icons.warning, 'Number Of Faults', _mrDetails!['NumberOfFaults']),
                                  const SizedBox(height: 24),
                                ],
                              ),
                            ),
                          ],
                        ),
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

  /* String _formatAssetVerified(dynamic value) {
    if (value == null || value.toString().isEmpty) return '------------';
    final str = value.toString().toLowerCase().trim();
    return (str == 'yes' || str == 'true') ? '✔' : '❌';
  } */

  /* String _formatActualStart(dynamic value) {
  // If the value is null or empty, return the placeholder
  if (value == null || value.toString().trim().isEmpty) {
    return '------------';
  }
  
  // Return the formatted date string directly
  return value.toString();
} */


}