import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../widgets/destination_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Destination> destinations = [
      Destination(
        title: "Cape Town",
        subtitle: "Table Mountain · Waterfront",
        imageUrl: "https://picsum.photos/400/300?1",
        description:
            "Cape Town is famous for its iconic Table Mountain, beautiful beaches, and vibrant culture.",
        rating: 4.8,
      ),
      Destination(
        title: "Durban",
        subtitle: "Beaches · Ushaka Marine",
        imageUrl: "https://picsum.photos/400/300?2",
        description:
            "Durban offers warm beaches, rich Indian culture, and some of the best food in South Africa.",
        rating: 4.6,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Discover Travel"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: destinations.length,
        itemBuilder: (context, index) {
          return DestinationCard(destination: destinations[index]);
        },
      ),
    );
  }
}
