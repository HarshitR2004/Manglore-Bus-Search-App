import 'dart:convert';
import 'package:http/http.dart' as http;

class GeocodingService {
  static const String _nominatimBaseUrl = 'https://nominatim.openstreetmap.org/search';
  static const String _osrmBaseUrl = 'https://routing.openstreetmap.de/routed-car/route/v1/driving/';

  Future<List<Map<String, dynamic>>> geocodeLocation(String location) async {
    try {
      final response = await http.get(
        Uri.parse('$_nominatimBaseUrl?q=${Uri.encodeComponent(location)}&format=json&limit=5'),
        headers: {
          'User-Agent': 'MangaloreBusRoutesApp/1.0',
        },
      );

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(json.decode(response.body));
      } else {
        throw Exception('Failed to geocode location');
      }
    } catch (e) {
      throw Exception('Geocoding error: $e');
    }
  }

  Future<Map<String, dynamic>> getRouteDirections(
      double startLat, double startLon, double endLat, double endLon) async {
    try {
      final response = await http.get(
        Uri.parse('$_osrmBaseUrl$startLon,$startLat;$endLon,$endLat?overview=full&geometries=geojson'),
        headers: {
          'User-Agent': 'MangaloreBusRoutesApp/1.0',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to fetch route directions');
      }
    } catch (e) {
      throw Exception('Routing error: $e');
    }
  }
}