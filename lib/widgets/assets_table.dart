import 'package:flutter/material.dart';
import '../pages/asset_details.dart';

class AssetTable extends StatelessWidget {
  final List<dynamic> assets;
  final bool isLoading;

  const AssetTable({
    super.key,
    required this.assets,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Asset ID')),
                DataColumn(label: Text('Name')),
              ],
              rows: assets.map<DataRow>((asset) {
                return DataRow(
                  cells: [
                    DataCell(
                      GestureDetector(
                        onTap: () {
                          _navigateToAssetDetails(context, asset['AssetID']);
                        },
                        child: Text(asset['AssetID'].toString()),
                      ),
                    ),
                    DataCell(
                      GestureDetector(
                        onTap: () {
                          _navigateToAssetDetails(context, asset['AssetID']);
                        },
                        child: Text(asset['Name'].toString()),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          );
  }

  void _navigateToAssetDetails(BuildContext context, String AssetID) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => AssetDetailsPage(AssetID: AssetID),
      ),
      (Route<dynamic> route) => false,
    );
  }
}
