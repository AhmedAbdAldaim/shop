import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData ligthTheme = ThemeData(
    fontFamily: 'Cairo',
    primarySwatch: Colors.deepPurple,
    scaffoldBackgroundColor: HexColor('#e2e2e2'),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      bodySmall: TextStyle(color: Colors.black),
      titleLarge: TextStyle(color: Colors.black),
      titleMedium: TextStyle(color: Colors.black),
      titleSmall: TextStyle(color: Colors.black),
    ),
    iconTheme: const IconThemeData(color: Colors.grey),
    listTileTheme: const ListTileThemeData(
        iconColor: Colors.grey, textColor: Colors.black),
    dividerTheme: const DividerThemeData(color: Colors.grey),
    cardColor: Colors.white,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(color: Colors.black, fontFamily: 'Cairo'),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey));

ThemeData darkTheme = ThemeData(
    fontFamily: 'Cairo',
    primarySwatch: Colors.deepPurple,
    scaffoldBackgroundColor: HexColor('#303030'),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white),
      titleSmall: TextStyle(color: Colors.white),
    ),
    iconTheme: const IconThemeData(color: Colors.grey),
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.grey,
      textColor: Colors.white,
    ),
    dividerTheme: const DividerThemeData(color: Colors.grey),
    cardColor: Colors.black45,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(color: Colors.white, fontFamily: 'Cairo'),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarIconBrightness: Brightness.light)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.grey));
