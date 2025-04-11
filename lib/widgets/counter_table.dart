import 'package:flutter/material.dart';
import '../pages/counter_details.dart';

class CountersTable extends StatelessWidget {
  final List<dynamic> counters;

  const CountersTable({super.key, required this.counters});

  @override
  Widget build(BuildContext context) {
    if (counters.isEmpty) {
      return const Center(
        child: Text("No counters found for this asset."),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          //DataColumn(label: Text('Counter ID')),
          DataColumn(label: Text('Asset')),
          DataColumn(label: Text('Functional Location')),
          DataColumn(label: Text('Counter')),
          DataColumn(label: Text('CounterReset')),
          //DataColumn(label: Text('Registered Date')),
          DataColumn(label: Text('Value')),
          DataColumn(label: Text('Unit')),
          //DataColumn(label: Text('AggregatedValue')),
          //DataColumn(label: Text('Totals')),
        ],
        rows: counters.map<DataRow>((counter) {
          final counterID = counter['_id'];
          return DataRow(
            cells: [
              //DataCell(Text(counter['CounterID']?.toString() ?? 'N/A'), onTap: () => _navigateToCounterDetails(context, counterID)),
              DataCell(Text(counter['Asset']?.toString() ?? 'N/A'), onTap: () => _navigateToCounterDetails(context, counterID)),
              DataCell(Text(counter['FunctionalLocation']?.toString() ?? 'N/A'), onTap: () => _navigateToCounterDetails(context, counterID)),
              DataCell(Text(counter['Counter']?.toString() ?? 'N/A'), onTap: () => _navigateToCounterDetails(context, counterID)),
              DataCell(Text(counter['CounterReset']?.toString() ?? 'N/A'), onTap: () => _navigateToCounterDetails(context, counterID)),
              //DataCell(Text(_formatDate(counter['Registered']) ?? 'N/A'), onTap: () => _navigateToCounterDetails(context, counterID)),
              DataCell(Text(counter['Value']?.toString() ?? 'N/A'), onTap: () => _navigateToCounterDetails(context, counterID)),
              DataCell(Text(counter['Unit']?.toString() ?? 'N/A'), onTap: () => _navigateToCounterDetails(context, counterID)),
              //DataCell(Text(counter['AggregatedValue']?.toString() ?? 'N/A'), onTap: () => _navigateToCounterDetails(context, counterID)),
              //DataCell(Text(counter['Totals']?.toString() ?? 'N/A'), onTap: () => _navigateToCounterDetails(context, counterID)),
            ],
          );
        }).toList(),
      ),
    );
  }

  void _navigateToCounterDetails(BuildContext context, String counterID) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CounterDetailsPage(CounterID: counterID),
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