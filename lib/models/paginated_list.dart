import 'bus_route.dart';

class PaginatedResponse {
  final int total;
  final int page;
  final int size;
  final int totalPages;
  final List<BusRoute> routes;

  PaginatedResponse({
    required this.total,
    required this.page,
    required this.size,
    required this.totalPages,
    required this.routes,
  });

  factory PaginatedResponse.fromJson(Map<String, dynamic> json) {
    return PaginatedResponse(
      total: json['total'],
      page: json['page'],
      size: json['size'],
      totalPages: json['total_pages'],
      routes: (json['routes'] as List).map((route) => BusRoute.fromJson(route)).toList(),
    );
  }
}
