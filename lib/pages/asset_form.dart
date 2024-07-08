import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test/pages/asset_page.dart';
import 'dart:convert';
import '../widgets/main_app_bar.dart';
import '../baseUrl.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/app_bar_body.dart';

class AssetForm extends StatefulWidget {
  const AssetForm({Key? key}) : super(key: key);

  @override
  _AssetFormState createState() => _AssetFormState();
}

class _AssetFormState extends State<AssetForm> {
  final TextEditingController _filterController = TextEditingController();

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      drawer: const DrawerWidget(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            appBarBody(context),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center( 
                  child: Text(
                    'Asset Form',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                  SizedBox(height: 16.0),
                  AssetFormFields(),
                  SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const AssetPage()),
                        (Route<dynamic> route) => false,
                        );
                      },
                      child: Text('Confirm'),
                    ),
                  ),
                  ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AssetFormFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 40.0),
        Text(
          'Asset ID',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Asset ID'),
        ),
        SizedBox(height: 40.0),
        Text(
          'Name',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Name'),
        ),
        SizedBox(height: 40.0),
        Text(
          'Number Of Children',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Number Of Children'),
        ),
        SizedBox(height: 40.0),
        Text(
          'Asset Type',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Asset Type'),
        ),
        SizedBox(height: 40.0),
        Text(
          'Manufacturer',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Manufacturer'),
        ),
        SizedBox(height: 40.0),
        Text(
          'Model',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Model'),
        ),
        SizedBox(height: 40.0),
        Text(
          'Customer Account',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Customer Account'),
        ),
        SizedBox(height: 40.0),
        Text(
          'Criticality',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Criticality'),
        ),
        SizedBox(height: 40.0),
        Text(
          'Functional Location',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Functional Location'),
        ),
        SizedBox(height: 40.0),
        Text(
          'Current Lifecycle State',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Current Lifecycle State'),
        ),
      ],
    );
  }
}
