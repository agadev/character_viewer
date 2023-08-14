import 'package:character_viewer/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  FlavorConfig(
      name: "Simpson Character",
      color: Colors.blue,
      location: BannerLocation.bottomStart,
      variables: {
        "appTitle": "Simpson Character Viewer",
        "apiUrl": "http://api.duckduckgo.com/?q=simpsons+characters&format=json",
      }
  );
  runApp(ProviderScope(
    child: MyApp(),
  ));
}