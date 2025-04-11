import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark, // Set to dark mode
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900, // Dark background color
    primary: Colors.blueGrey, // Set a primary color
    onPrimary: Colors.white, // Text color for primary widgets
    surface: Colors.grey.shade800, // Surface color for elements like cards
    onSurface: Colors.white, // Text color for surface elements
  ),
  textTheme: ThemeData.dark().textTheme.apply(
    bodyColor: Colors.grey[300],
    displayColor: Colors.white,
  ),
);

