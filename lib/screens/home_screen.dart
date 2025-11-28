import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../widgets/destination_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Destination> destinations = [
      Destination(
        name: "Cape Town",
        location: "Table Mountain · Waterfront",
        image: "https://picsum.photos/400/300?1",
        description:
            "Cape Town is famous for its iconic Table Mountain, beautiful beaches, and vibrant culture.",
        rating: 4.8,
        category: "City",
        latitude: -33.9249,
        longitude: 18.4241,

      ),
      Destination(
        name: "Durban",
        location: "Beaches · Ushaka Marine",
        image: "https://picsum.photos/400/300?2",
        description:
            "Durban offers warm beaches, rich Indian culture, and some of the best food in South Africa.",
        rating: 4.6,
        category: "City",
        latitude: -29.8587,
        longitude: 31.0218,

      ),

      Destination(
        name: "Krugar Park",
        location: "Mpumalanga",
        image: "https://picsum.photos/400/300?2",
        description:
            "A large game reserve in South Africa...",
        rating: 4.9,
        category: "Nature",
        latitude: -23.9884,
        longitude: 31.5547,
      )
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
