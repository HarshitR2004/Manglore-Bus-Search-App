import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/bus_route.dart';
import '../models/paginated_list.dart';

class Bus_Route_Service {
  static const String baseUrl = 'https://app-bootcamp.iris.nitk.ac.in';

  // getting all bus routes from the API
  Future<PaginatedResponse> getBusRoutes({int page = 1, int size = 20}) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/bus_routes/?page=$page&size=$size'));

      if (response.statusCode == 200) {
        return PaginatedResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load bus routes');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // getting the bus routes between two locations
  Future<List<BusRoute>> searchRoutes(
      {String? fromLocation, String? toLocation}) async {
    try {
      final queryParams = <String, String>{};
      if (fromLocation != null) queryParams['from_location'] = fromLocation;
      if (toLocation != null) queryParams['to_location'] = toLocation;

      final uri = Uri.parse('$baseUrl/bus_routes/search/')
          .replace(queryParameters: queryParams);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((route) => BusRoute.fromJson(route)).toList();
      } else {
        throw Exception('Failed to search routes');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // getting specific bus details
  Future<BusRoute> getRouteDetails(String busNumber) async {
    try {
      final response =
      await http.get(Uri.parse('$baseUrl/bus_routes/$busNumber'));

      if (response.statusCode == 200) {
        return BusRoute.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load route details');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}

