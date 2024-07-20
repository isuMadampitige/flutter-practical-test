import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.orange[800],
  fontFamily: GoogleFonts.poppins().fontFamily,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
        fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
    bodySmall: TextStyle(fontSize: 16.0, color: Colors.white70),
  ),
  appBarTheme: AppBarTheme(
    color: Colors.blueGrey[800],
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.orange),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.orange),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.orange),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.orange),
    ),
  ),
);
