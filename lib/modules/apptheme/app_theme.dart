import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getLightTheme() {
    return ThemeData(
      useMaterial3: true,
      primaryColor: Colors.white,
      scaffoldBackgroundColor: const Color(0xFFE8EBF0),
      dividerColor: const Color(0xFF2C2B3B),
      hintColor: Colors.white70,
      cardTheme: const CardTheme(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 3.0,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
          color: Color(0xFF39374C),
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
      tabBarTheme: TabBarTheme(
        indicatorColor: const Color(0xFF2C2B3B),
        dividerColor: Colors.transparent,
        labelColor: const Color(0xFF2C2B3B),
        unselectedLabelColor: const Color(0xFF39374C).withAlpha(200),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.red,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
        unselectedItemColor: const Color(0xFF39374C).withAlpha(200),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF39374C),
      scaffoldBackgroundColor: const Color(0xFF2C2B3B),
      dividerColor: Colors.white30,
      cardColor: const Color(0xFF39374C),
      listTileTheme: const ListTileThemeData(
        iconColor: Colors.white,
        textColor: Colors.white,
        selectedTileColor: Colors.red,
        selectedColor: Colors.red,
        tileColor: Color(0xFF2C2B3B),
      ),
      cardTheme: CardTheme(
        color: const Color(0xFF39374C),
        surfaceTintColor: const Color(0xFF39374C),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadowColor: Colors.black.withAlpha(100),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF39374C),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      tabBarTheme: const TabBarTheme(
        indicatorColor: Colors.white,
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF39374C),
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}
