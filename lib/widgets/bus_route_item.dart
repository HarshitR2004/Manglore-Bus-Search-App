import 'package:flutter/material.dart';
import '../models/bus_route.dart';

class BusRouteItem extends StatelessWidget {
  final BusRoute busRoute;
  BusRouteItem(this.busRoute);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Bus: ${busRoute.busNumber}'),
      subtitle: Text('${busRoute.fromLocation} to ${busRoute.toLocation}\nRoute: ${busRoute.route}'),
      onTap: () {
        Navigator.pushNamed(context, '/details', arguments: busRoute.busNumber);
      },
    );
  }
}