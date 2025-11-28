import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/destination.dart';

class ApiServices {
  static const String _baseUrl = "https://api.opentripmap.com/0.1/en/places";
  static const String _apiKey = "YOUR_API_KEY_HERE";

  /// Get places around coordinates (lat, lon)
  Future<List<Destination>> fetchDestinations({
    double lat = -33.9249, // Cape Town default
    double lon = 18.4241,
    int radius = 5000,
    int limit = 20,
  }) async {
    final url = Uri.parse(
      "$_baseUrl/radius?radius=$radius&lon=$lon&lat=$lat&format=json&limit=$limit&apikey=$_apiKey",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      // Convert each API place into a Destination object
      return data.map((item) {
        final point = item['point'] ?? {};
        return Destination(
          name: item['name'] ?? "Unknown Place",
          location: item['kinds'] ?? "Unknown Location",
          description: item['name'] ?? "No description available",
          image: "assets/images/default.jpg", // placeholder image
          rating: 4.0, // default rating
          category: "City", // default category
          latitude: point['lat']?.toDouble() ?? 0.0,
          longitude: point['lon']?.toDouble() ?? 0.0,
        );
      }).toList();
    } else {
      throw Exception("Error fetching places: ${response.statusCode}");
    }
  }
}
