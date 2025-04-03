import 'package:flutter/material.dart';



ThemeData lightMode = ThemeData(
  brightness: Brightness.light, // Set to light mode
  colorScheme: ColorScheme.light(
    background: Colors.white, // Light background color
    primary: Colors.blue, // Set a primary color
    onPrimary: Colors.black, // Text color for primary widgets
    surface: Colors.grey.shade100, // Surface color for elements like cards
    onSurface: Colors.black, // Text color for surface elements
  ),
  textTheme: ThemeData.light().textTheme.apply(
    bodyColor: Colors.amber, // Body text color
    displayColor: Colors.black, // Display text color
  ),
);
