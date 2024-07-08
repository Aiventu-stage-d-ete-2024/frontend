import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../baseURL.dart';
import '../pages/mr_details.dart';

class MaintenanceRequestsTable extends StatefulWidget {
  const MaintenanceRequestsTable({Key? key}) : super(key: key);

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
                    DataCell(
                      GestureDetector(
                        onTap: () {
                          _navigateToMRDetails(context, request['RequestID']);
                        },
                        child: Text(request['RequestID'].toString()),
                      ),
                    ),
                    DataCell(
                      GestureDetector(
                        onTap: () {
                          _navigateToMRDetails(context, request['RequestID']);
                        },
                        child: Text(request['RequestType'].toString()),
                      ),
                    ),
                    DataCell(
                      GestureDetector(
                        onTap: () {
                          _navigateToMRDetails(context, request['RequestID']);
                        },
                        child: Text(request['Asset'].toString()),
                      ),
                    ),
                    DataCell(
                      GestureDetector(
                        onTap: () {
                          _navigateToMRDetails(context, request['RequestID']);
                        },
                        child: Text(request['Description'].toString()),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          );
  }

  void _navigateToMRDetails(BuildContext context, String RequestID) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MRDetailsPage(RequestID: RequestID),
      ),
    );
  }
}
