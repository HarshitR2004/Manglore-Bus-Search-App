import 'package:flutter/material.dart';
import '../services/bus_route_service.dart';
import '../screens/bus_route_detail_screen.dart';
import '../models/bus_route.dart';



class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Bus_Route_Service apiService = Bus_Route_Service();
  final fromController = TextEditingController();
  final toController = TextEditingController();
  List<BusRoute> searchResults = [];
  bool isLoading = false;
  String? error;

  Future<void> searchRoutes() async {
    if (fromController.text.isEmpty && toController.text.isEmpty) {
      return;
    }

    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final results = await apiService.searchRoutes(
        fromLocation: fromController.text.isEmpty ? null : fromController.text,
        toLocation: toController.text.isEmpty ? null : toController.text,
      );
      setState(() {
        searchResults = results;
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
        title: const Text(
          'Search Routes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.black87
          ),
        ),
        backgroundColor: Colors.blueAccent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: fromController,
                  decoration: InputDecoration(
                    labelText: 'From Location',
                    hintText: 'Enter starting location',
                    prefixIcon: const Icon(
                        Icons.location_on, color: Colors.blueAccent),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: toController,
                  decoration: InputDecoration(
                    labelText: 'To Location',
                    hintText: 'Enter destination',
                    prefixIcon: const Icon(
                        Icons.location_on, color: Colors.redAccent),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: searchRoutes,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Search',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget buildSearchResults() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
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
              onPressed: searchRoutes,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('Retry', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }

    if (searchResults.isEmpty) {
      return const Center(
        child: Text(
          'No routes found. Try different locations.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final route = searchResults[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          elevation: 4,
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Text(
              'Bus ${route.busNumber}',
              style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '${route.fromLocation} to ${route.toLocation}',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(
                  color: Colors.black87,
                ),
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      RouteDetailScreen(busNumber: route.busNumber),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

