import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../baseURL.dart';

class AssetTable extends StatefulWidget {
  const AssetTable({super.key});

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
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Asset')),
                DataColumn(label: Text('Name')),
              ],
              rows: _assets.map<DataRow>((asset) {
                return DataRow(
                  cells: [
                    DataCell(Text(asset['AssetID'].toString())),
                    DataCell(Text(asset['Name'].toString())),
                  ],
                );
              }).toList(),
            ),
          );
  }
}
