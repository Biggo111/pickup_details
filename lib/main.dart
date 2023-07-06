import 'package:flutter/material.dart';
import 'package:pickup_details/constants/colors.dart';
import 'package:pickup_details/screens/pickup_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pickup Details',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: scaffoldBackgroundColor),
        useMaterial3: true,
      ),
      home: const PickupDetailsScreen(screenTitle: 'Pickup Details'),
    );
  }
}