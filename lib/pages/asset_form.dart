import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../baseURL.dart';
import '../pages/asset_page.dart';
import '../widgets/main_app_bar.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/asset_app_bar_body.dart';

class AssetForm extends StatefulWidget {
  const AssetForm({super.key});

  @override
  _AssetFormState createState() => _AssetFormState();
}

class _AssetFormState extends State<AssetForm> {
  final TextEditingController _assetIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _parentController = TextEditingController();
  final TextEditingController _numberOfChildrenController = TextEditingController();
  final TextEditingController _assetTypeController = TextEditingController();
  final TextEditingController _manufacturerController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _customerAccountController = TextEditingController();
  final TextEditingController _criticalityController = TextEditingController();
  final TextEditingController _functionalLocationController = TextEditingController();
  final TextEditingController _currentLifecycleStateController = TextEditingController();

  @override
  void dispose() {
    _assetIdController.dispose();
    _nameController.dispose();
    _parentController.dispose();
    _numberOfChildrenController.dispose();
    _assetTypeController.dispose();
    _manufacturerController.dispose();
    _modelController.dispose();
    _customerAccountController.dispose();
    _criticalityController.dispose();
    _functionalLocationController.dispose();
    _currentLifecycleStateController.dispose();
    super.dispose();
  }

  Future<void> _createAsset() async {
    final url = Uri.parse('${baseUrl}assets');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'AssetID': _assetIdController.text,
        'Name': _nameController.text,
        'Parent': _parentController.text,
        'NumberOfChildren': _numberOfChildrenController.text,
        'AssetType': _assetTypeController.text,
        'Manufacturer': _manufacturerController.text,
        'Model': _modelController.text,
        'CustomerAccount': _customerAccountController.text,
        'Criticality': _criticalityController.text,
        'FunctionalLocation': _functionalLocationController.text,
        'CurrentLifecycleState': _currentLifecycleStateController.text,
      }),
    );

    if (response.statusCode == 201) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const AssetPage()),
        (Route<dynamic> route) => false,
      );
    } else {
      // Handle the error
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to create asset'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
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
            assetAppBarBody(context, isAssetDetailsPage: true),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  AssetFormFields(
                    assetIdController: _assetIdController,
                    nameController: _nameController,
                    parentController:_parentController,
                    numberOfChildrenController: _numberOfChildrenController,
                    assetTypeController: _assetTypeController,
                    manufacturerController: _manufacturerController,
                    modelController: _modelController,
                    customerAccountController: _customerAccountController,
                    criticalityController: _criticalityController,
                    functionalLocationController: _functionalLocationController,
                    currentLifecycleStateController: _currentLifecycleStateController,
                  ),
                  const SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: _createAsset,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Text('Confirm'),
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
  final TextEditingController assetIdController;
  final TextEditingController nameController;
  final TextEditingController parentController;
  final TextEditingController numberOfChildrenController;
  final TextEditingController assetTypeController;
  final TextEditingController manufacturerController;
  final TextEditingController modelController;
  final TextEditingController customerAccountController;
  final TextEditingController criticalityController;
  final TextEditingController functionalLocationController;
  final TextEditingController currentLifecycleStateController;

  const AssetFormFields({
    super.key,
    required this.assetIdController,
    required this.nameController,
    required this.parentController,
    required this.numberOfChildrenController,
    required this.assetTypeController,
    required this.manufacturerController,
    required this.modelController,
    required this.customerAccountController,
    required this.criticalityController,
    required this.functionalLocationController,
    required this.currentLifecycleStateController,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              labelText: 'Asset ID',
              controller: assetIdController,
            ),
            const SizedBox(height: 20.0),
            CustomTextFormField(
              labelText: 'Name',
              controller: nameController,
            ),
            const SizedBox(height: 20.0),
            CustomTextFormField(
              labelText: 'Parent',
              controller: parentController,
            ),
            const SizedBox(height: 20.0),
            CustomTextFormField(
              labelText: 'Number Of Children',
              controller: numberOfChildrenController,
            ),
            const SizedBox(height: 20.0),
            CustomTextFormField(
              labelText: 'Asset Type',
              controller: assetTypeController,
            ),
            const SizedBox(height: 20.0),
            CustomTextFormField(
              labelText: 'Manufacturer',
              controller: manufacturerController,
            ),
            const SizedBox(height: 20.0),
            CustomTextFormField(
              labelText: 'Model',
              controller: modelController,
            ),
            const SizedBox(height: 20.0),
            CustomTextFormField(
              labelText: 'Customer Account',
              controller: customerAccountController,
            ),
            const SizedBox(height: 20.0),
            CustomTextFormField(
              labelText: 'Criticality',
              controller: criticalityController,
            ),
            const SizedBox(height: 20.0),
            CustomTextFormField(
              labelText: 'Functional Location',
              controller: functionalLocationController,
            ),
            const SizedBox(height: 20.0),
            CustomTextFormField(
              labelText: 'Current Lifecycle State',
              controller: currentLifecycleStateController,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        floatingLabelStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF3665DB),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color(0xFF3665DB), width: 2.0),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
      style: const TextStyle(fontSize: 16),
    );
  }
}
