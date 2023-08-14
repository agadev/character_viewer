import 'package:character_viewer/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  FlavorConfig(
      name: "Wire Character",
      color: Colors.red,
      location: BannerLocation.bottomStart,
      variables: {
        "appTitle": "Wire Character Viewer",
        "apiUrl": "http://api.duckduckgo.com/?q=the+wire+characters&format=json",
      }
  );
  runApp(ProviderScope(
    child: MyApp(),
  ));
}
