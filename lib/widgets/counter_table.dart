import 'package:flutter/material.dart';
import '../pages/counter_details.dart';

class CountersTable extends StatelessWidget {
  final List<dynamic> counters;
  final String AssetID;

  const CountersTable(
      {super.key, required this.counters, required this.AssetID});

  @override
  Widget build(BuildContext context) {
    if (counters.isEmpty) {
      return const Center(
        child: Text("No counters found for this asset."),
      );
    }

    return SingleChildScrollView(
      child: DataTable(
        columnSpacing: 20,
        columns: const [
          //DataColumn(label: Text('Counter ID')),
          DataColumn(label: Text('Asset')),
          //DataColumn(label: Text('Functional Location')),
          DataColumn(label: Text('Counter')),
          //DataColumn(label: Text('CounterReset')),
          //DataColumn(label: Text('Registered Date')),
          DataColumn(label: Text('Value')),
          DataColumn(label: Text('Unit')),
          //DataColumn(label: Text('AggregatedValue')),
          //DataColumn(label: Text('Totals')),
        ],
        rows: counters.map<DataRow>((counter) {
          final counterID = counter['_id'];
          final AssetID = counter['Asset'];
          //print('Counter ID: $counterID');
          //print('Asset ID: $AssetID');
          return DataRow(
            cells: [
              //DataCell(Text(counter['CounterID']?.toString() ?? ''), onTap: () => _navigateToCounterDetails(context, counterID, AssetID)),
              DataCell(Text(counter['Asset']?.toString() ?? ''),
                  onTap: () =>
                      _navigateToCounterDetails(context, counterID, AssetID)),
              //DataCell(Text(counter['FunctionalLocation']?.toString() ?? ''), onTap: () => _navigateToCounterDetails(context, counterID, AssetID)),
              DataCell(Text(counter['Counter']?.toString() ?? ''),
                  onTap: () =>
                      _navigateToCounterDetails(context, counterID, AssetID)),
              //DataCell(Text(counter['CounterReset']?.toString() ?? ''), onTap: () => _navigateToCounterDetails(context, counterID, AssetID)),
              //DataCell(Text(_formatDate(counter['Registered']) ?? ''), onTap: () => _navigateToCounterDetails(context, counterID, AssetID)),
              DataCell(Text(counter['Value']?.toString() ?? ''),
                  onTap: () =>
                      _navigateToCounterDetails(context, counterID, AssetID)),
              DataCell(Text(counter['Unit']?.toString() ?? ''),
                  onTap: () =>
                      _navigateToCounterDetails(context, counterID, AssetID)),
              //DataCell(Text(counter['AggregatedValue']?.toString() ?? ''), onTap: () => _navigateToCounterDetails(context, counterID, AssetID)),
              //DataCell(Text(counter['Totals']?.toString() ?? ''), onTap: () => _navigateToCounterDetails(context, counterID, AssetID)),
            ],
          );
        }).toList(),
      ),
    );
  }

  void _navigateToCounterDetails(
      BuildContext context, String counterID, String AssetID) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            CounterDetailsPage(CounterID: counterID, AssetID: AssetID),
      ),
    );
  }
}
/* String? _formatDate(String? dateString) {
  if (dateString == null) return null;
  try {
    final DateTime dateTime = DateTime.parse(dateString);  // Assuming the date is in ISO format.
    final DateFormat formatter = DateFormat('M/d/yyyy h:mm:ss a');
    return formatter.format(dateTime);
  } catch (e) {
    print('Error formatting date: $e');
    return dateString;  // Return the original string if formatting fails
  }
} */
