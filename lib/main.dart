import 'package:expences_calculator/expences.dart';
import 'package:flutter/material.dart';

var kcolorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(223, 15, 55, 235));
var kdartTheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(119, 30, 35, 45),
);
void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData().copyWith(
        colorScheme: kdartTheme,
        cardTheme: const CardTheme().copyWith(
          color: kdartTheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kdartTheme.primaryContainer,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kcolorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kcolorScheme.onPrimaryContainer,
          foregroundColor: kcolorScheme.onInverseSurface,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kcolorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kcolorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.normal,
                color: kcolorScheme.onSecondaryContainer,
                fontSize: 16,
              ),
            ),
      ),
      home: const Expences(),
    ),
  );
}
