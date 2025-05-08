import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/asset_app_bar_body.dart';
import '../widgets/main_app_bar.dart';
import '../widgets/drawer_widget.dart';
import '../baseUrl.dart';

class AssetDetailsPage extends StatefulWidget {
  final String AssetID;

  const AssetDetailsPage({super.key, required this.AssetID});

  @override
  _AssetDetailsPageState createState() => _AssetDetailsPageState();
}

class _AssetDetailsPageState extends State<AssetDetailsPage> {
  Map<String, dynamic>? _assetDetails;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAssetDetails();
  }

  Future<void> _fetchAssetDetails() async {
    final url = Uri.parse('${baseUrl}assets/${widget.AssetID}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _assetDetails = data;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load asset details');
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
          : _assetDetails == null
              ? const Center(child: Text('Asset details not found'))
              : Column(
                  children: [
                    assetAppBarBody(context,
                        isAssetDetailsPage: true, assetDetails: _assetDetails),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(16),
                        children: [
                          const SizedBox(height: 16),
                          const Center(
                            child: Text(
                              'Asset Details',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3665DB),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildDetailCard(Icons.confirmation_number,
                              'Asset ID', _assetDetails!['AssetID']),
                          _buildDetailCard(Icons.inventory_2, 'Name',
                              _assetDetails!['Name']),
                          _buildDetailCard(Icons.account_tree, 'Parent',
                              _assetDetails!['Parent']),
                          _buildDetailCard(Icons.supervisor_account, 'Children',
                              _assetDetails!['NumberOfChildren']),
                          _buildDetailCard(Icons.category, 'Asset Type',
                              _assetDetails!['AssetType']),
                          _buildDetailCard(Icons.precision_manufacturing,
                              'Manufacturer', _assetDetails!['Manufacturer']),
                          _buildDetailCard(Icons.devices_other, 'Model',
                              _assetDetails!['Model']),
                          _buildDetailCard(
                              Icons.account_box,
                              'Customer Account',
                              _assetDetails!['CustomerAccount']),
                          _buildDetailCard(Icons.report_problem, 'Criticality',
                              _assetDetails!['Criticality']),
                          _buildDetailCard(
                              Icons.location_on,
                              'Functional Location',
                              _assetDetails!['FunctionalLocation']),
                          _buildDetailCard(
                              Icons.timeline,
                              'Current Lifecycle State',
                              _assetDetails!['CurrentLifecycleState']),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _buildDetailCard(IconData icon, String title, dynamic value) {
    String displayValue = value == null || value.toString().isEmpty
        ? '------------'
        : value.toString();

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
