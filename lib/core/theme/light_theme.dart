import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  fontFamily: GoogleFonts.poppins().fontFamily,
  primaryColor: Colors.blue,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black87),
  ),
  appBarTheme: const AppBarTheme(
      color: Colors.blue,
      elevation: 0, // No shadow

      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white)),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue),
    ),
  ),
);
