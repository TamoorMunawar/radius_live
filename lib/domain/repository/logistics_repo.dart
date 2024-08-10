import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../entities/logictis/logistics.dart';

Map<String, String> authorizationHeaders(SharedPreferences prefs) {
  final token = prefs.getString("token");
  return {
    "Content-Type": "application/json",
    "Authorization": "Bearer $token",
  };
}

class BuyAssetRepository {
  final String apiUrl = "https://radiusapp.online/api/v1/buy-asset-history";

  Future<List<BuyAssetHistory>> fetchBuyAssets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final headers = authorizationHeaders(prefs);

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: headers,
      );

      print('API URL: $apiUrl');
      print('Headers: $headers');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> data = jsonResponse['data'];

        // Use a Set to filter out duplicates
        final uniqueAssets = <BuyAssetHistory>{};
        for (var item in data) {
          final asset = BuyAssetHistory.fromJson(item);
          uniqueAssets.add(asset);
        }

        return uniqueAssets.toList();
      } else {
        throw Exception('Failed to load assets, status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle errors
      print('Error fetching assets: $e');
      throw Exception('Error fetching assets: $e');
    }
  }
}
