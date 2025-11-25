import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/destination.dart';
import '../widgets/destination_card.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  late Box<String> favBox;

  @override
  void initState() {
    super.initState();
    favBox = Hive.box<String>('favorites');
  }

  @override
  Widget build(BuildContext context) {
    List<Destination> favoriteDestinations = destinations
        .where((d) => favBox.containsKey(d.name))
        .toList();

    if (favoriteDestinations.isEmpty) {
      return const Center(
        child: Text('No favorites yet 😞', style: TextStyle(fontSize: 16)),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: favoriteDestinations.length,
      itemBuilder: (context, i) {
        return DestinationCard(destination: favoriteDestinations[i]);
      },
    );
  }
}
