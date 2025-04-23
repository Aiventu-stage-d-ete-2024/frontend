import 'package:flutter/material.dart';
import '../pages/mr_details.dart';

class MaintenanceRequestsTable extends StatelessWidget {
  final List<dynamic> maintenanceRequests;
  final bool isLoading;

  const MaintenanceRequestsTable({
    super.key,
    required this.maintenanceRequests,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Request ID')),
          DataColumn(label: Text('Request Type')),
          DataColumn(label: Text('Asset')),
          DataColumn(label: Text('Description')),
        ],
        rows: maintenanceRequests.map<DataRow>((request) {
          return DataRow(
            cells: [
              DataCell(GestureDetector(
                onTap: () => _navigateToMRDetails(context, request['RequestID']),
                child: Text(request['RequestID'].toString()),
              )),
              DataCell(GestureDetector(
                onTap: () => _navigateToMRDetails(context, request['RequestID']),
                child: Text(request['RequestType'].toString()),
              )),
              DataCell(GestureDetector(
                onTap: () => _navigateToMRDetails(context, request['RequestID']),
                child: Text(request['Asset']?.toString() ?? ''),
              )),
              DataCell(GestureDetector(
                onTap: () => _navigateToMRDetails(context, request['RequestID']),
                child: Text(request['Description'].toString()),
              )),
            ],
          );
        }).toList(),
      ),
    );
  }

  void _navigateToMRDetails(BuildContext context, String requestID) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => MRDetailsPage(RequestID: requestID),
      ),
      (route) => false,
    );
  }
}
