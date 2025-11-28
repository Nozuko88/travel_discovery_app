import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/destination.dart';

class MapScreen extends StatelessWidget {
final Destination destination;

const MapScreen({super.key, required this.destination});

@override
Widget build(BuildContext context) {
final LatLng destinationLatLng = LatLng(destination.latitude, destination.longitude);


return Scaffold(
  appBar: AppBar(
    title: Text(destination.name),
    centerTitle: true,
  ),
  body: FlutterMap(
    options: MapOptions(
      initialCenter: destinationLatLng,
      initialZoom: 13.0,
    ),
    children: [
      TileLayer(
        urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
        userAgentPackageName: 'travel_discovery_app',
      ),
      MarkerLayer(
        markers: [
          Marker(
            point: destinationLatLng,
            width: 80,
            height: 80,
            child: const Icon(
              Icons.location_on,
              size: 40,
              color: Colors.red,
            ),
          ),
        ],
      ),
    ],
  ),
);


}
}
