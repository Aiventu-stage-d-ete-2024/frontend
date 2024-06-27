import 'package:flutter/material.dart';
import 'main.dart';
import 'maintenancerequests.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AssetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assets'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF041431),
              ),
              child: Text(
                'Menu',
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
              title: Text('Maintenance Requests'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MaintenanceRequestsScreen()),
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
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 30,
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Filter',
                            prefixIcon: Icon(Icons.search),
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  AssetTable(), // Replace with your AssetTable widget
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
     final url = Uri.parse('http://192.168.12.23:3000/api/assets');
     final response = await http.get(url);

     if (response.statusCode == 200) {
       final data = json.decode(response.body);
       setState(() {
         _assets = data['assets'];
         _isLoading = false;
       });
     } else {
       // Handle the error
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
                 DataColumn(label: Text('Parent')),
                 DataColumn(label: Text('Children')),
                 DataColumn(label: Text('Asset type')),
                 DataColumn(label: Text('Manufacturer')),
                 DataColumn(label: Text('Model')),
                 DataColumn(label: Text('Customer account')),
                 DataColumn(label: Text('Criticality')),
                 DataColumn(label: Text('Functional location')),
                 DataColumn(label: Text('Current lifecycle state')),
               ],
               rows: _assets.map<DataRow>((asset) {
                 return DataRow(
                   cells: [
                     DataCell(Text(asset['AssetID'].toString())),
                     DataCell(Text(asset['Name'].toString())),
                     DataCell(Text(asset['Parent'].toString())),
                     DataCell(Text(asset['NumberOfChildren'].toString())),
                     DataCell(Text(asset['AssetType'].toString())),
                     DataCell(Text(asset['Manufacturer'].toString())),
                     DataCell(Text(asset['Model'].toString())),
                     DataCell(Text(asset['CustomerAccount'].toString())),
                     DataCell(Text(asset['Criticality'].toString())),
                     DataCell(Text(asset['FunctionalLocation'].toString())),
                     DataCell(Text(asset['CurrentLifecycleState'].toString())),
                   ],
                 );
               }).toList(),
             ),
           );
   }
}
