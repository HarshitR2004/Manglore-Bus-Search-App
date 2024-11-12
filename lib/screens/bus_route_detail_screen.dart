import 'package:flutter/material.dart';
import '../services/bus_route_service.dart';
import '../models/bus_route.dart';

class RouteDetailScreen extends StatefulWidget {
  final String busNumber;

  const RouteDetailScreen({super.key, required this.busNumber});

  @override
  State<RouteDetailScreen> createState() => _RouteDetailScreenState();
}

class _RouteDetailScreenState extends State<RouteDetailScreen> {
  final Bus_Route_Service apiService = Bus_Route_Service();
  BusRoute? _route;
  bool isLoading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    loadRouteDetails();
  }

  Future<void> loadRouteDetails() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final route = await apiService.getRouteDetails(widget.busNumber);
      setState(() {
        _route = route;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus ${widget.busNumber} Details'),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Error: $error',
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: loadRouteDetails,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_route == null) {
      return const Center(
        child: Text('Route not found', style: TextStyle(fontSize: 18)),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bus ${_route!.busNumber}',
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.green),
                      const SizedBox(width: 8),
                      Text(
                        'From: ${_route!.fromLocation}',
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.red),
                      const SizedBox(width: 8),
                      Text(
                        'To: ${_route!.toLocation}',
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Route:',
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(thickness: 1, color: Colors.grey),
                  const SizedBox(height: 8),
                  Text(
                    _route!.route,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyLarge,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
