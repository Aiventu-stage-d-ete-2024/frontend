import 'package:flutter/material.dart';
import 'assets.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MaintenanceRequestsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maintenance Requests'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Side Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage(title: 'Finance and Operations')),
                );
              },
            ),
            ListTile(
              title: Text('All assets'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AssetScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'All maintenance requests',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 16.0),
                  MaintenanceRequestsTable(), // Replace with your MaintenanceRequestsTable widget
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
     final url = Uri.parse('http://192.168.12.23:3000/api/maintenancerequests');
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
                 DataColumn(label: Text('Description')),
                 DataColumn(label: Text('Service Level')),
                 DataColumn(label: Text('Functional Location')),
                 DataColumn(label: Text('Asset')),
                 DataColumn(label: Text('Asset Verified')),
                 DataColumn(label: Text('Job Type')),
                 DataColumn(label: Text('Job Variant')),
                 DataColumn(label: Text('Job Trade')),
                 DataColumn(label: Text('Actual Start')),
                 DataColumn(label: Text('Started By Worker')),
                 DataColumn(label: Text('Responsible Worker Group')),
                 DataColumn(label: Text('Responsible Worker')),
                 DataColumn(label: Text('Current Lifecycle State')),
                 DataColumn(label: Text('Number Of Faults')),
               ],
               rows: _maintenanceRequests.map<DataRow>((request) {
                 return DataRow(
                   cells: [
                     DataCell(Text(request['RequestID'].toString())),
                     DataCell(Text(request['RequestType'].toString())),
                     DataCell(Text(request['Description'].toString())),
                     DataCell(Text(request['ServiceLevel'].toString())),
                     DataCell(Text(request['FunctionalLocation'].toString())),
                     DataCell(Text(request['Asset'].toString())),
                     DataCell(Text(request['AssetVerified'].toString())),
                     DataCell(Text(request['JobType'].toString())),
                     DataCell(Text(request['JobVariant'].toString())),
                     DataCell(Text(request['JobTrade'].toString())),
                     DataCell(Text(request['ActualStart'].toString())),
                     DataCell(Text(request['StartedByWorker'].toString())),
                     DataCell(Text(request['ResponsibleWorkerGroup'].toString())),
                     DataCell(Text(request['ResponsibleWorker'].toString())),
                     DataCell(Text(request['CurrentLifecycleState'].toString())),
                     DataCell(Text(request['NumberOfFaults'].toString())),
                   ],
                 );
               }).toList(),
             ),
           );
   }
}
