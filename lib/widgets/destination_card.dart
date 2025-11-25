import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/destination.dart';
import '../screens/details_screen.dart';

class DestinationCard extends StatefulWidget {
  final Destination destination;
  const DestinationCard({super.key, required this.destination});

  @override
  State<DestinationCard> createState() => _DestinationCardState();
}

class _DestinationCardState extends State<DestinationCard> {
  late Box<String> favBox;

  @override
  void initState() {
    super.initState();
    favBox = Hive.box<String>('favorites');
  }

  bool isFavorite() {
    return favBox.containsKey(widget.destination.name);
  }

  void toggleFavorite() {
    if (isFavorite()) {
      favBox.delete(widget.destination.name);
    } else {
      favBox.put(widget.destination.name, widget.destination.name);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailsScreen(destination: widget.destination),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Hero(
              tag: widget.destination.image,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  widget.destination.image,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.destination.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text(widget.destination.location,
                          style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      isFavorite() ? Icons.favorite : Icons.favorite_border,
                      color: Colors.deepPurple,
                    ),
                    onPressed: toggleFavorite,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
