import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/main_app_bar.dart';
import '../baseUrl.dart';
import '../widgets/assets_table.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/asset_app_bar_body.dart';

class AssetPage extends StatefulWidget {
  const AssetPage({super.key});

  @override
  _AssetPageState createState() => _AssetPageState();
}

class _AssetPageState extends State<AssetPage> {
  List<dynamic> _assets = [];
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchAssets('');
  }

  Future<void> _searchAssets(String query) async {
    final url = Uri.parse('${baseUrl}assets/search?query=$query');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _assets = data;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        throw Exception('Failed to search assets');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Search error: $e');
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
            assetAppBarBody(context, isAssetDetailsPage: false),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'All assets',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 30,
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Filter',
                            prefixIcon: Icon(Icons.search),
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _isLoading = true;
                              _searchQuery = value;
                            });
                            _searchAssets(value);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  AssetTable(
                    assets: _assets,
                    isLoading: _isLoading,
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
