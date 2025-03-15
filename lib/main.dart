import 'package:flutter/material.dart';
import 'package:flutter_201/screens/tabs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

var kColorSchema =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));

var kDarkColorSchema = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: kDarkColorSchema,
  cardTheme: const CardTheme().copyWith(
    color: kDarkColorSchema.secondaryContainer,
    margin: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: kDarkColorSchema.primaryContainer,
        foregroundColor: kDarkColorSchema.onPrimaryContainer),
  ),
);

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: kColorSchema,
  appBarTheme: const AppBarTheme().copyWith(
    backgroundColor: kColorSchema.onPrimaryContainer,
    foregroundColor: kColorSchema.primaryContainer,
  ),
  cardTheme: const CardTheme().copyWith(
    color: kColorSchema.secondaryContainer,
    margin: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kColorSchema.primaryContainer,
    ),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 201',
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme,
      theme: theme,
      home: const BottomMenuScreen(),
    );
  }
}
