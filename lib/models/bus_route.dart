class BusRoute {
  final String busNumber;
  final String fromLocation;
  final String toLocation;
  final String route;

  BusRoute({
    required this.busNumber,
    required this.fromLocation,
    required this.toLocation,
    required this.route,
  });

  factory BusRoute.fromJson(Map<String, dynamic> json) {
    return BusRoute(
      busNumber: json['bus_number'],
      fromLocation: json['from_location'],
      toLocation: json['to_location'],
      route: json['route'],
    );
  }
}



