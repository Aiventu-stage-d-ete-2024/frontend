import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../baseURL.dart';

class MaintenanceRequestsTable extends StatefulWidget {
  const MaintenanceRequestsTable({super.key});

  @override
  _MaintenanceRequestsTableState createState() => _MaintenanceRequestsTableState();
}

class _MaintenanceRequestsTableState extends State<MaintenanceRequestsTable> {
  List<dynamic> _maintenanceRequests = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMaintenanceRequests();
  }

  Future<void> _fetchMaintenanceRequests() async {
    final url = Uri.parse('${baseUrl}maintenancerequests');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _maintenanceRequests = data['maintenanceRequests'];
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load maintenance requests');
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
                DataColumn(label: Text('Request ID')),
                DataColumn(label: Text('Request Type')),
                DataColumn(label: Text('Asset')),
                DataColumn(label: Text('Description')),
              ],
              rows: _maintenanceRequests.map<DataRow>((request) {
                return DataRow(
                  cells: [
                    DataCell(Text(request['RequestID'].toString())),
                    DataCell(Text(request['RequestType'].toString())),
                    DataCell(Text(request['Asset'].toString())),
                    DataCell(Text(request['Description'].toString())),
                  ],
                );
              }).toList(),
            ),
          );
  }
}
