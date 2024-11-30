import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../services/location_service.dart';

class RouteMapScreen extends StatefulWidget {
  final String fromLocation;
  final String toLocation;

  const RouteMapScreen({
    super.key,
    required this.fromLocation,
    required this.toLocation,
  });

  @override
  State<RouteMapScreen> createState() => _RouteMapScreenState();
}

class _RouteMapScreenState extends State<RouteMapScreen> {
  final GeocodingService _geocodingService = GeocodingService();
  List<LatLng> _routePoints = [];
  LatLng? _startPoint;
  LatLng? _endPoint;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchRouteCoordinates();
  }

  Future<void> _fetchRouteCoordinates() async {
    try {
      // Validate input locations
      if (widget.fromLocation.isEmpty || widget.toLocation.isEmpty) {
        throw Exception('Start and end locations must not be empty');
      }

      // Geocode start location
      final startResults = await _geocodingService.geocodeLocation(widget.fromLocation);
      if (startResults.isEmpty) {
        throw Exception('Could not find coordinates for start location: ${widget.fromLocation}');
      }
      final startLocation = startResults.first;
      _startPoint = LatLng(
        double.parse(startLocation['lat']),
        double.parse(startLocation['lon']),
      );

      // Geocode end location
      final endResults = await _geocodingService.geocodeLocation(widget.toLocation);
      if (endResults.isEmpty) {
        throw Exception('Could not find coordinates for end location: ${widget.toLocation}');
      }
      final endLocation = endResults.first;
      _endPoint = LatLng(
        double.parse(endLocation['lat']),
        double.parse(endLocation['lon']),
      );

      // Fetch route directions
      final routeData = await _geocodingService.getRouteDirections(
        _startPoint!.latitude,
        _startPoint!.longitude,
        _endPoint!.latitude,
        _endPoint!.longitude,
      );

      // Extract and convert route coordinates
      final geometry = routeData['routes'][0]['geometry']['coordinates'];
      _routePoints = geometry
          .map<LatLng>((coord) => LatLng(coord[1], coord[0]))
          .toList();

      // Update state
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      // Improved error handling
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to load route: ${e.toString()}';
          _isLoading = false;
        });
      }
    }
  }

  Widget _buildErrorWidget() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route: ${widget.fromLocation} to ${widget.toLocation}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            const SizedBox(height: 16),
            Text(
              _errorMessage ?? 'An unknown error occurred',
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchRouteCoordinates,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Loading state
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Route: ${widget.fromLocation} to ${widget.toLocation}'),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading route...'),
            ],
          ),
        ),
      );
    }

    if (_errorMessage != null) {
      return _buildErrorWidget();
    }

    // Validate route points
    if (_startPoint == null || _endPoint == null || _routePoints.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Route: ${widget.fromLocation} to ${widget.toLocation}'),
        ),
        body: const Center(
          child: Text('Unable to display route. Please try again.'),
        ),
      );
    }

    // Map view
    return Scaffold(
      appBar: AppBar(
        title: Text('Route: ${widget.fromLocation} to ${widget.toLocation}'),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: _startPoint!,
          initialZoom: 13.0,
          minZoom: 3.0,
          maxZoom: 18.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
            errorImage: const AssetImage('assets/error_tile.png'),
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: _routePoints,
                strokeWidth: 5.0,
                color: Colors.blue.shade700,
                gradientColors: [
                  Colors.blue.shade500,
                  Colors.blue.shade900,
                ],
              ),
            ],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: _startPoint!,
                width: 40.0,
                height: 40.0,
                child: const Icon(
                  Icons.radio_button_checked,
                  color: Colors.green,
                  size: 40.0,
                ),
              ),
              Marker(
                point: _endPoint!,
                width: 40.0,
                height: 40.0,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

