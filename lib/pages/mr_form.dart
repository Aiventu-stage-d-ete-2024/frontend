import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../pages/mr_page.dart';
import '../widgets/main_app_bar.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/mr_app_bar_body.dart';

class MaintenanceRequestForm extends StatefulWidget {
  const MaintenanceRequestForm({Key? key}) : super(key: key);

  @override
  _MaintenanceRequestFormState createState() => _MaintenanceRequestFormState();
}

class _MaintenanceRequestFormState extends State<MaintenanceRequestForm> {
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
            mrAppBarBody(context,isMRDetailsPage: true),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*Center(
                    child: Text(
                      'Maintenance Request Form',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),*/
                  SizedBox(height: 20.0),
                  MaintenanceRequestFormFields(),
                  SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const MaintenancePage()),
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

class MaintenanceRequestFormFields extends StatefulWidget {
  @override
  _MaintenanceRequestFormFieldsState createState() => _MaintenanceRequestFormFieldsState();
}

class _MaintenanceRequestFormFieldsState extends State<MaintenanceRequestFormFields> {
  bool _isAssetVerified = false;
  final TextEditingController _actualStartController = TextEditingController();

Future<void> _selectDateTime(BuildContext context) async {
  DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: Color(0xFF3665DB),
          dialogBackgroundColor: Colors.white, colorScheme: ColorScheme.light(
            primary: Color(0xFF3665DB),
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Color(0xFF3665DB),
          ).copyWith(secondary: Color(0xFF3665DB)),
        ),
        child: child!,
      );
    },
  );

  if (selectedDate != null) {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xFF3665DB),
            dialogBackgroundColor: Colors.white, colorScheme: ColorScheme.light(
              primary: Color(0xFF3665DB),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF3665DB),
            ).copyWith(secondary: Color(0xFF3665DB)),
          ),
          child: child!,
        );
      },
    );

    if (selectedTime != null) {
      final DateTime selectedDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      final String formattedDateTime = DateFormat('M/d/yyyy h:mm:ss a').format(selectedDateTime);
      setState(() {
        _actualStartController.text = formattedDateTime;
      });
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(labelText: 'Maintenance Request'),
            SizedBox(height: 20.0),
            CustomTextFormField(labelText: 'Maintenance Request Type'),
            SizedBox(height: 20.0),
            CustomTextFormField(labelText: 'Description'),
            SizedBox(height: 20.0),
            CustomTextFormField(labelText: 'Service Level'),
            SizedBox(height: 20.0),
            CustomTextFormField(labelText: 'Functional Location'),
            SizedBox(height: 20.0),
            CustomTextFormField(labelText: 'Asset'),
            SizedBox(height: 20.0),
            //CustomTextFormField(labelText: 'Asset Verified'),
            /*CheckboxListTile(
              title: Text('Asset Verified'),
              value: _isAssetVerified,
              onChanged: (bool? value) {
                setState(() {
                  _isAssetVerified = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Color(0xFF3665DB),
            ),
            SizedBox(height: 20.0),*/
            CustomTextFormField(labelText: 'Maintenance Job Type'),
            SizedBox(height: 20.0),
            CustomTextFormField(labelText: 'Maintenance Job Type Variant'),
            SizedBox(height: 20.0),
            CustomTextFormField(labelText: 'Trade'),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () => _selectDateTime(context),
              child: AbsorbPointer(
                child: CustomTextFormField(
                  labelText: 'Actual Start',
                  controller: _actualStartController,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            CustomTextFormField(labelText: 'Started By'),
            SizedBox(height: 20.0),
            CustomTextFormField(labelText: 'Responsible Group'),
            SizedBox(height: 20.0),
            CustomTextFormField(labelText: 'Responsible'),
            SizedBox(height: 20.0),
            CustomTextFormField(labelText: 'Work Order'),
            SizedBox(height: 20.0),
            CustomTextFormField(labelText: 'Current Lifecycle State'),
            SizedBox(height: 20.0),
            CustomTextFormField(labelText: 'Number of faults'),
          ],
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;

  const CustomTextFormField({
    required this.labelText,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        floatingLabelStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF3665DB),
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
