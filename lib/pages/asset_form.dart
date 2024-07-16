import 'package:flutter/material.dart';
import '../pages/asset_page.dart';
import '../widgets/main_app_bar.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/asset_app_bar_body.dart'; // Import here

class AssetForm extends StatefulWidget {
  const AssetForm({super.key});

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
            assetAppBarBody(context, isAssetDetailsPage: true),
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
                  const SizedBox(height: 20.0),
                  const AssetFormFields(),
                  const SizedBox(height: 20.0),
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
  const AssetFormFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: const Column(
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

  const CustomTextFormField({super.key, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        floatingLabelStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF3665DB)
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
