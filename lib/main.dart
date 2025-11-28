import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/home_screen.dart';
import 'screens/explore_screen.dart';
import 'screens/favourites_screen.dart';
import 'screens/map_screen.dart';
import 'widgets/bottom_nav.dart';
import 'models/destination.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
await Hive.initFlutter();
await Hive.openBox<String>('favorites'); // store favorite destination names
runApp(const TravelApp());
}

class TravelApp extends StatefulWidget {
const TravelApp({super.key});

@override
State<TravelApp> createState() => _TravelAppState();
}

class _TravelAppState extends State<TravelApp> {
int _currentIndex = 0;

late final List<Widget> _screens;

@override
void initState() {
super.initState();
// Add a dummy destination for MapScreen (or use the first one from your ExploreScreen list)
Destination defaultDestination = Destination(
name: "Cape Town",
location: "Table Mountain · Waterfront",
image: "assets/images/capetown.jpg",
description: "Cape Town is famous for Table Mountain...",
rating: 4.8,
category: "City",
latitude: -33.9249,
longitude: 18.4241,
);

_screens = [
  const HomeScreen(),
  const ExploreScreen(),
  const FavouritesScreen(),
  MapScreen(destination: defaultDestination),
];


}

@override
Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,
title: 'Travel Discovery App',
theme: ThemeData(
useMaterial3: true,
colorSchemeSeed: Colors.deepPurple,
),
home: Scaffold(
body: _screens[_currentIndex],
bottomNavigationBar: BottomNav(
currentIndex: _currentIndex,
onTap: (index) => setState(() => _currentIndex = index),
),
),
);
}
}
