import 'package:aqua/First_page/HomePage.dart';
import 'package:aqua/SQL_imp.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as ft;
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io';


void main() async{
  String apiKey = Platform.environment['API_KEY'] ?? 'API_KEY_NOT_FOUND';
  Gemini.init(apiKey: apiKey);
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();

  // Set the default factory for database creation
  databaseFactory = databaseFactoryFfi;

  add_input();

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ft.FluentApp(
      debugShowCheckedModeBanner: false,

      title: 'AquaView',
      theme: ft.FluentThemeData(

        fontFamily: 'CustomFont',
        accentColor: ft.Colors.blue,
        brightness: Brightness.light
      ),
      home: const MainPage(),
    );
  }
}



