import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test/pages/mr_details.dart';
import '../pages/mr_page.dart';
import '../widgets/main_app_bar.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/mr_app_bar_body.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../baseURL.dart';

class MaintenanceRequestForm extends StatefulWidget {
  final bool isUpdate;
  final Map<String, dynamic>? mrDetails;

  const MaintenanceRequestForm({super.key, this.isUpdate = false, this.mrDetails});

  @override
  _MaintenanceRequestFormState createState() => _MaintenanceRequestFormState();
}

class _MaintenanceRequestFormState extends State<MaintenanceRequestForm> {
  final TextEditingController _requestIDController = TextEditingController();
  final TextEditingController _requestTypeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _serviceLevelController = TextEditingController();
  final TextEditingController _functionalLocationController = TextEditingController();
  final TextEditingController _jobTypeController = TextEditingController();
  final TextEditingController _jobVariantController = TextEditingController();
  final TextEditingController _jobTradeController = TextEditingController();
  final TextEditingController _actualStartController = TextEditingController();
  final TextEditingController _startedByController = TextEditingController();
  final TextEditingController _responsibleGroupController = TextEditingController();
  final TextEditingController _responsibleController = TextEditingController();
  final TextEditingController _workOrderController = TextEditingController();
  final TextEditingController _currentLifecycleStateController = TextEditingController();
  final TextEditingController _numberOfFaultsController = TextEditingController();
  
  List<dynamic> assets = [];
  String? selectedAsset;

  @override
  void initState() {
    super.initState();
    fetchAssets();
    if (widget.isUpdate && widget.mrDetails != null) {
      _populateFields();
    }
  }

  void _populateFields() {
    final details = widget.mrDetails!;
    _requestIDController.text = details['RequestID']?.toString() ?? '';
    _requestTypeController.text = details['RequestType']?.toString() ?? '';
    _descriptionController.text = details['Description']?.toString() ?? '';
    _serviceLevelController.text = details['ServiceLevel']?.toString() ?? '';
    _functionalLocationController.text = details['FunctionalLocation']?.toString() ?? '';
    selectedAsset = details['Asset']?.toString();
    _jobTypeController.text = details['JobType']?.toString() ?? '';
    _jobVariantController.text = details['JobVariant']?.toString() ?? '';
    _jobTradeController.text = details['JobTrade']?.toString() ?? '';
    _actualStartController.text = details['ActualStart']?.toString() ?? '';
    _startedByController.text = details['StartedByWorker']?.toString() ?? '';
    _responsibleGroupController.text = details['ResponsibleWorkerGroup']?.toString() ?? '';
    _responsibleController.text = details['ResponsibleWorker']?.toString() ?? '';
    _workOrderController.text = details['WorkOrder']?.toString() ?? '';
    _currentLifecycleStateController.text = details['CurrentLifecycleState']?.toString() ?? '';
    _numberOfFaultsController.text = details['NumberOfFaults']?.toString() ?? '';
  }

  @override
  void dispose() {
    _requestIDController.dispose();
    _requestTypeController.dispose();
    _descriptionController.dispose();
    _serviceLevelController.dispose();
    _functionalLocationController.dispose();
    _jobTypeController.dispose();
    _jobVariantController.dispose();
    _jobTradeController.dispose();
    _startedByController.dispose();
    _responsibleGroupController.dispose();
    _responsibleController.dispose();
    _workOrderController.dispose();
    _currentLifecycleStateController.dispose();
    _numberOfFaultsController.dispose();
    _actualStartController.dispose();
    super.dispose();
  }

  Future<void> fetchAssets() async {
    try {
      final response = await http.get(Uri.parse('${baseUrl}assets'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          assets = data['assets'];
        });
      } else {
        throw Exception('Failed to load assets');
      }
    } catch (e) {
      _showErrorDialog('Failed to load assets: $e');
    }
  }

  Future<void> createMaintenanceRequest() async {
    final url = Uri.parse('${baseUrl}maintenanceRequests');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(_buildRequestPayload()),
    );

    if (response.statusCode == 201) {
      _navigateToMaintenancePage();
    } else {
       //print('Response body: ${response.body}');
      _showErrorDialog('Failed to create request');
    }
  }

  Future<void> updateMaintenanceRequest() async {
    final url = Uri.parse('${baseUrl}maintenanceRequests/${widget.mrDetails!['_id']}');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(_buildRequestPayload()),
    );

    if (response.statusCode == 200) {
      //print('Response body: ${response.body}');
      _navigateToMRDetailsPage();
    } else {
      //print('Response body: ${response.body}');
      _showErrorDialog('Failed to update request');
    }
  }

  void _navigateToMRDetailsPage() {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => MRDetailsPage(RequestID: _requestIDController.text),
    ),
  );
}

  Map<String, dynamic> _buildRequestPayload() {
    return {
      'RequestID': _requestIDController.text,
      'RequestType': _requestTypeController.text,
      'Description': _descriptionController.text,
      'ServiceLevel': int.tryParse(_serviceLevelController.text) ?? 0,
      'FunctionalLocation': _functionalLocationController.text,
      'AssetID': selectedAsset,
      'JobType': _jobTypeController.text,
      'JobVariant': _jobVariantController.text,
      'JobTrade': _jobTradeController.text,
      'ActualStart': _actualStartController.text,
      'StartedByWorker': _startedByController.text,
      'ResponsibleWorkerGroup': _responsibleGroupController.text,
      'ResponsibleWorker': _responsibleController.text,
      'WorkOrder': _workOrderController.text,
      'CurrentLifecycleState': _currentLifecycleStateController.text,
      'NumberOfFaults': int.tryParse(_numberOfFaultsController.text) ?? 0,
    };
  }

  void _navigateToMaintenancePage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MaintenancePage()),
      (Route<dynamic> route) => false,
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

  Future<void> _selectDateAndTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: const Color(0xFF3665DB), colorScheme: const ColorScheme.light(primary: Color(0xFF3665DB)).copyWith(secondary: const Color(0xFF3665DB)), dialogTheme: const DialogThemeData(backgroundColor: Colors.white), // Background color of the dialog
        ),
        child: child!,
      );
    },
  );

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: const Color(0xFF3665DB),
          colorScheme: const ColorScheme.light(primary: Color(0xFF3665DB)), dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
        ),
        child: child!,
      );
    },
  );

    if (pickedTime != null) {
      DateTime finalDateTime = DateTime(
        pickedDate!.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      _actualStartController.text = DateFormat('yyyy-MM-dd HH:mm').format(finalDateTime);
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
            mrAppBarBody(context, isMRDetailsPage: true),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  CustomTextFormField(labelText: 'Maintenance Request', controller: _requestIDController),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(labelText: 'Maintenance Request Type', controller: _requestTypeController),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(labelText: 'Description', controller: _descriptionController),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(labelText: 'Service Level', controller: _serviceLevelController),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(labelText: 'Functional Location', controller: _functionalLocationController),
                  const SizedBox(height: 20.0),
                  DropdownButtonFormField<String>(
                    value: selectedAsset,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Select An Asset',
                      labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                      floatingLabelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF3665DB)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Color(0xFF3665DB), width: 2.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    ),
                    items: assets.map<DropdownMenuItem<String>>((asset) {
                      return DropdownMenuItem<String>(
                        value: asset['AssetID'],
                        child: Text('${asset['AssetID']} : ${asset['Name']}'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedAsset = value;
                        print('Selected Asset: $selectedAsset');
                      });
                    },
                    dropdownColor: Colors.white,
                    isExpanded: true,
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(labelText: 'Maintenance Job Type', controller: _jobTypeController),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(labelText: 'Maintenance Job Variant', controller: _jobVariantController),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(labelText: 'Maintenance Job Trade', controller: _jobTradeController),
                  const SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: _selectDateAndTime,
                    child: AbsorbPointer(
                      child: CustomTextFormField(
                        labelText: 'Actual Start',
                        controller: _actualStartController,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(labelText: 'Started By', controller: _startedByController),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(labelText: 'Responsible Worker Group', controller: _responsibleGroupController),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(labelText: 'Responsible Worker', controller: _responsibleController),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(labelText: 'Work Order', controller: _workOrderController),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(labelText: 'Current Lifecycle State', controller: _currentLifecycleStateController),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(labelText: 'Number Of Faults', controller: _numberOfFaultsController),
                  const SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: widget.isUpdate ? updateMaintenanceRequest : createMaintenanceRequest,
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
