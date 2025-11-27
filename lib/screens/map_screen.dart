import 'package:flutter/material.dart';
import '../models/destination.dart';

class MapScreen extends StatelessWidget {
  final Destination destination;

  const MapScreen({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(destination != null
          ? 'Map for ${destination!.name}'
          : 'Map Screen'),
    );
  }
}
