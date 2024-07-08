import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test/pages/asset_page.dart';
import 'dart:convert';
import '../widgets/main_app_bar.dart';
import '../baseUrl.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/asset_app_bar_body.dart'; // Import here

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
            assetAppBarBody(context),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*Center(
                    child: Text(
                      'Asset Form',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),*/
                  SizedBox(height: 20.0),
                  AssetFormFields(),
                  SizedBox(height: 20.0),
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
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        textStyle: TextStyle(fontSize: 18),
                      ),
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
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(labelText: 'Asset ID'),
            SizedBox(height: 20.0),
            CustomTextFormField(labelText: 'Name'),
            SizedBox(height: 20.0),
            CustomTextFormField(labelText: 'Number Of Children'),
            SizedBox(height: 20.0),
            CustomTextFormField(labelText: 'Asset Type'),
            SizedBox(height: 20.0),
            CustomTextFormField(labelText: 'Manufacturer'),
            SizedBox(height: 20.0),
            CustomTextFormField(labelText: 'Model'),
            SizedBox(height: 20.0),
            CustomTextFormField(labelText: 'Customer Account'),
            SizedBox(height: 20.0),
            CustomTextFormField(labelText: 'Criticality'),
            SizedBox(height: 20.0),
            CustomTextFormField(labelText: 'Functional Location'),
            SizedBox(height: 20.0),
            CustomTextFormField(labelText: 'Current Lifecycle State'),
          ],
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final String labelText;

  const CustomTextFormField({required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        floatingLabelStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF3665DB)
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Color(0xFF3665DB), width: 2.0),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
      style: TextStyle(fontSize: 16),
    );
  }
}
