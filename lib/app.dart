import 'package:character_viewer/features/home/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Character Viewer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: FlavorConfig.instance.color,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}
