import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../widgets/destination_card.dart';
import '../widgets/category_filter.dart';

class ExploreScreen extends StatefulWidget {
const ExploreScreen({super.key});

@override
State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
String searchText = "";
String selectedCategory = "All";

List<String> categories = [
"All",
"Beach",
"City",
"Nature",
"Adventure",
"Luxury"
];

// Sample destinations
final List<Destination> destinations = [
Destination(
name: "Cape Town",
location: "Table Mountain · Waterfront",
image: "assets/images/capetown.jpg", // or network URL
description: "Cape Town is famous for Table Mountain...",
rating: 4.8,
category: "City",
),
Destination(
name: "Durban",
location: "Beaches · Ushaka Marine",
image: "assets/images/durban.jpg",
description: "Durban offers warm beaches...",
rating: 4.6,
category: "Beach",
),
Destination(
name: "Kruger Park",
location: "Mpumalanga",
image: "assets/images/kruger.jpg",
description: "A large game reserve in South Africa...",
rating: 4.9,
category: "Nature",
),
];

@override
Widget build(BuildContext context) {
// 1. Filter by search text
List<Destination> filtered = destinations
.where((d) =>
d.name.toLowerCase().contains(searchText.toLowerCase()) ||
d.location.toLowerCase().contains(searchText.toLowerCase()))
.toList();

// 2. Filter by category (except "All")
if (selectedCategory != "All") {
  filtered = filtered
      .where((d) => d.category == selectedCategory)
      .toList();
}

return Scaffold(
  backgroundColor: Colors.grey.shade100,
  appBar: AppBar(
    title: const Text("Explore"),
    centerTitle: true,
  ),
  body: Column(
    children: [
      // 🔍 Search Bar
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: TextField(
          decoration: InputDecoration(
            hintText: "Search destinations...",
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (value) {
            setState(() => searchText = value);
          },
        ),
      ),

      // 🏷 Category Filters
      SizedBox(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, i) {
            return CategoryFilter(
              label: categories[i],
              isSelected: categories[i] == selectedCategory,
              onTap: () {
                setState(() => selectedCategory = categories[i]);
              },
            );
          },
        ),
      ),

      const SizedBox(height: 10),

      // 🧳 Results
      Expanded(
        child: filtered.isEmpty
            ? const Center(
                child: Text(
                  "No destinations found 😞",
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: filtered.length,
                itemBuilder: (context, i) {
                  return DestinationCard(destination: filtered[i]);
                },
              ),
      ),
    ],
  ),
);
}
}
