import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../baseURL.dart';
import '../pages/counter_page.dart';
import '../widgets/main_app_bar.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/counter_app_bar_body.dart';

class CounterForm extends StatefulWidget {
  final bool isUpdate;
  final Map<String, dynamic>? counterDetails;

  const CounterForm({super.key, this.isUpdate = false, this.counterDetails});

  @override
  _CounterFormState createState() => _CounterFormState();
}

class _CounterFormState extends State<CounterForm> {
  final TextEditingController _counterIDController = TextEditingController();
  final TextEditingController _assetController = TextEditingController();
  final TextEditingController _functionalLocationController = TextEditingController();
  final TextEditingController _counterNameController = TextEditingController();
  final TextEditingController _counterResetController = TextEditingController();
  final TextEditingController _registeredDateController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _aggregatedValueController = TextEditingController();
  final TextEditingController _totalsController = TextEditingController();

  List assets = [];
  String? selectedAsset;

  Map<String, String> assetFunctionalLocations = {};
 
  @override
  void initState() {
    super.initState();
    fetchAssets();
    if (widget.isUpdate && widget.counterDetails != null) {
      _populateFields();
    }
  }

  void _populateFields() {
    final details = widget.counterDetails!;
    _counterIDController.text = details['CounterID']?.toString() ?? '';
    //_assetController.text = details['Asset']?.toString() ?? '';
    selectedAsset = details['Asset'];
    _functionalLocationController.text = details['FunctionalLocation']?.toString() ?? '';
    _counterNameController.text = details['Counter']?.toString() ?? '';
    _counterResetController.text = details['CounterReset']?.toString() ?? '';
    _registeredDateController.text = details['Registered']?.toString() ?? '';
    _valueController.text = details['Value']?.toString() ?? '';
    _unitController.text = details['Unit']?.toString() ?? '';
    _aggregatedValueController.text = details['AggregatedValue']?.toString() ?? '';
    _totalsController.text = details['Totals']?.toString() ?? '';
  }

  @override
  void dispose() {
    _counterIDController.dispose();
    _assetController.dispose();
    _functionalLocationController.dispose();
    _counterNameController.dispose();
    _counterResetController.dispose();
    _registeredDateController.dispose();
    _valueController.dispose();
    _unitController.dispose();
    _aggregatedValueController.dispose();
    _totalsController.dispose();
    super.dispose();
  }

  Future<void> fetchAssets() async {
    try {
      final response = await http.get(Uri.parse('${baseUrl}assets'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          assets = data['assets'];
          for (var asset in assets) {
            assetFunctionalLocations[asset['AssetID']] = asset['FunctionalLocation'];
          }
        });
      } else {
        throw Exception('Failed to load assets');
      }
    } catch (e) {
      _showErrorDialog('Failed to load assets: $e');
    }
  }

  Future<void> createCounter() async {
    final url = Uri.parse('${baseUrl}counters');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(_buildCounterPayload()),
    );

    if (response.statusCode == 201) {
      _navigateToCountersPage();
    } else {
      _showErrorDialog('Failed to create counter');
    }
  }

  Future<void> updateCounter() async {
    final url = Uri.parse('${baseUrl}counters/${widget.counterDetails!['_id']}');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(_buildCounterPayload()),
    );

    if (response.statusCode == 200) {
      _navigateToCountersPage();
    } else {
      _showErrorDialog('Failed to update counter');
    }
  }

  Map<String, dynamic> _buildCounterPayload() {
    return {
      'CounterID': _counterIDController.text,
      'AssetID': selectedAsset,
      'FunctionalLocation': _functionalLocationController.text,
      'Counter': _counterNameController.text,
      'CounterReset': _counterResetController.text,
      'Registered': _registeredDateController.text,
      'Value': double.tryParse(_valueController.text) ?? 0.0,
      'Unit': _unitController.text,
      'AggregatedValue': double.tryParse(_aggregatedValueController.text) ?? 0.0,
      'Totals': double.tryParse(_totalsController.text) ?? 0.0,
    };
  }

  void _navigateToCountersPage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const CounterPage()),
      (Route route) => false,
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: const Color(0xFF3665DB),
          dialogBackgroundColor: Colors.white, colorScheme: const ColorScheme.light(primary: Color(0xFF3665DB)).copyWith(secondary: const Color(0xFF3665DB)), // Background color of the dialog
        ),
        child: child!,
      );
    },
  );

    _registeredDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate!);
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
            counterAppBarBody(context, isCounterDetailsPage: true, counterDetails: widget.counterDetails),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /* CustomTextFormField(labelText: 'Counter ID', controller: _counterIDController),
                  const SizedBox(height: 20.0), */
                  DropdownButtonFormField(
                  isExpanded: true,
                  value: selectedAsset,
                  decoration: InputDecoration(
                  labelText: 'Select An Asset',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  ),
                  items: assets.map((asset) {
                  return DropdownMenuItem(
                    value: asset['AssetID'],
                    child: Text('${asset['AssetID']} : ${asset['Name']}'),
                  );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedAsset = value as String?;
                      _functionalLocationController.text = assetFunctionalLocations[value] ?? '';
                    });
                  },
                  dropdownColor: Colors.white,
                ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: 'Functional Location',
                    controller: _functionalLocationController,
                    readOnly: true,
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(labelText: 'Counter Name', controller: _counterNameController),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(labelText: 'Counter Reset', controller: _counterResetController),
                  const SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: _selectDate,
                    child: AbsorbPointer(
                      child: CustomTextFormField(
                        labelText: 'Registered Date',
                        controller: _registeredDateController,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(labelText: 'Value', controller: _valueController),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(labelText: 'Unit', controller: _unitController),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(labelText: 'Aggregated Value', controller: _aggregatedValueController),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(labelText: 'Totals', controller: _totalsController),
                  const SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: widget.isUpdate ? updateCounter : createCounter,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF3665DB),
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

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool readOnly;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.controller,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        floatingLabelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF3665DB)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
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