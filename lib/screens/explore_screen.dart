import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../widgets/destination_card.dart';
import '../widgets/category_filter.dart';
import '../services/api_services.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String searchText = "";
  String selectedCategory = "All";
  final ApiServices api = ApiServices();

  List<String> categories = ["All", "Beach", "City", "Nature", "Adventure", "Luxury"];
  List<Destination> destinations = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDestinations();
  }

  Future<void> fetchDestinations() async {
    try {
      final result = await api.fetchDestinations();
      setState(() {
        destinations = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching destinations: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Destination> filtered = destinations
        .where((d) =>
            d.name.toLowerCase().contains(searchText.toLowerCase()) ||
            d.location.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    if (selectedCategory != "All") {
      filtered = filtered.where((d) => d.category == selectedCategory).toList();
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Explore"),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
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
                Expanded(
                  child: filtered.isEmpty
                      ? const Center(child: Text("No destinations found 😞"))
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
