import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../baseURL.dart';
import '../pages/asset_details.dart';

class AssetTable extends StatefulWidget {
  const AssetTable({Key? key}) : super(key: key);

  @override
  _AssetTableState createState() => _AssetTableState();
}

class _AssetTableState extends State<AssetTable> {
  List<dynamic> _assets = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAssets();
  }

  Future<void> _fetchAssets() async {
    final url = Uri.parse('${baseUrl}assets');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _assets = data['assets'];
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load assets');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Asset ID')),
                DataColumn(label: Text('Name')),
              ],
              rows: _assets.map<DataRow>((asset) {
                return DataRow(
                  cells: [
                    DataCell(
                      GestureDetector(
                        onTap: () {
                          _navigateToAssetDetails(context, asset['AssetID']);
                        },
                        child: Text(asset['AssetID'].toString()),
                      ),
                    ),
                    DataCell(Text(asset['Name'].toString())),
                  ],
                );
              }).toList(),
            ),
          );
  }

  void _navigateToAssetDetails(BuildContext context, String AssetID) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AssetDetailsPage(AssetID: AssetID),
      ),
    );
  }
}
