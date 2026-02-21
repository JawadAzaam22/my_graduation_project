import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
    primaryColor: const Color(0xFF0F083D),

    iconTheme: const IconThemeData(color: Colors.black),
    textTheme: const TextTheme(
      bodyLarge:
          TextStyle(color: Color(0xFF747474), fontWeight: FontWeight.w400),
      bodyMedium:
          TextStyle(color: Color(0xFF000000), fontWeight: FontWeight.w700),
    ),
    navigationBarTheme: const NavigationBarThemeData(backgroundColor: Colors.white),
    inputDecorationTheme: const InputDecorationTheme(
      iconColor: Color(0xFF3F3F3F),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFD9D9D9)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFD9D9D9)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF514F6E)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
    ),
    colorScheme: const ColorScheme.light(
      primaryContainer: Color.fromRGBO(210, 228, 255, 0.3),
      secondaryContainer: Colors.white,
      tertiary: Colors.white,
    ),
     outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        side: const BorderSide(color: Color(0xFFD9D9D9)),
        foregroundColor: Colors.black,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),

    appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF121212)),
    primaryColor: const Color(0xFF444444),
    colorScheme: const ColorScheme.dark(
      primaryContainer: Color(0xFF444444),
      secondaryContainer: Color(0xFF121212),
      tertiary: Color(0xFF444444),
    ),
    navigationBarTheme:
        NavigationBarThemeData(backgroundColor: Color(0xFF1E1E1E)),

    iconTheme: const IconThemeData(color: Colors.white),

    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      bodyLarge: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
    ),

    inputDecorationTheme: const InputDecorationTheme(
      iconColor: Colors.white,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF444444)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF444444)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF888888)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF444444),
        foregroundColor: Colors.white,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.black,
        side: const BorderSide(color: Colors.grey),
        foregroundColor: Colors.white,
      ),
    ),
  );
}
