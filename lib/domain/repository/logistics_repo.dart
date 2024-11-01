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
  final String apiUrl = "https://radiusapp.online/api/v1/get-user-logistics";

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
      print("assets list");
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        final List<dynamic> data = jsonResponse['data'];

        // Create a list of BuyAssetHistory objects
        List<BuyAssetHistory> assets = data.map((item) => BuyAssetHistory.fromJson(item)).toList();
print(assets.length);
print("assets list");
        return assets;
      } else {
        throw Exception('Failed to load assets, status code: ${response.statusCode},');
      }
    } catch (e) {
      // Handle errors
      print('Error fetching assets: $e');
      throw Exception('Error fetching assets: $e');
    }
  }
}
