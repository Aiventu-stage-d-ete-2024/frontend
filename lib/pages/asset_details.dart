import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/asset_app_bar_body.dart';
import 'dart:convert';
import '../widgets/main_app_bar.dart';
import '../baseUrl.dart';
import '../widgets/drawer_widget.dart';
// import the counter page

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    assetAppBarBody(context, isAssetDetailsPage: true, assetDetails: _assetDetails),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            const Center(
                              child: Text(
                                'Asset Details',
                                style: TextStyle(
                                  fontSize: 18,
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
                                  _buildDetailRow('Asset ID', _assetDetails!['AssetID'].toString()),
                                  _buildDetailRow('Name', _assetDetails!['Name'].toString()),
                                  _buildDetailRow('Parent', _assetDetails!['Parent'].toString()),
                                  _buildDetailRow('Children', _assetDetails!['NumberOfChildren'].toString()),
                                  _buildDetailRow('Asset Type', _assetDetails!['AssetType'].toString()),
                                  _buildDetailRow('Manufacturer', _assetDetails!['Manufacturer'].toString()),
                                  _buildDetailRow('Model', _assetDetails!['Model'].toString()),
                                  _buildDetailRow('Customer Account', _assetDetails!['CustomerAccount'].toString()),
                                  _buildDetailRow('Criticality', _assetDetails!['Criticality'].toString()),
                                  _buildDetailRow('Functional Location', _assetDetails!['FunctionalLocation'].toString()),
                                  _buildDetailRow('Current Lifecycle State', _assetDetails!['CurrentLifecycleState'].toString()),
                                  const SizedBox(height: 24),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
