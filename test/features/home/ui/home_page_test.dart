import 'package:character_viewer/app.dart';
import 'package:character_viewer/features/home/data/character_repository.dart';
import 'package:character_viewer/features/home/domain/home_controller.dart';
import 'package:character_viewer/features/home/ui/character_detail_page.dart';
import 'package:character_viewer/features/home/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../common_data.dart';
import '../domain/home_controller_test.dart';


void main() {
  final charactersRepository = MockCharacterRepository();
  when(() => charactersRepository.getCharacters()).thenAnswer((_) {
    return Future.value(fakeCharactersListNoImage);
  });

  final providerOverrides = [
   appTitleProvider.overrideWithValue("Simpsons Viewer App"),
    apiUrlProvider.overrideWithValue("url"),
    homeControllerProvider.overrideWithProvider(
        StateNotifierProvider((ref) =>
            HomeController(charactersRepository))),
  ];

  testWidgets('MyHomePage displays a list of characters', (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(
        overrides: providerOverrides,
        child:MyApp()));

    await tester.pumpAndSettle();
    expect(find.text('Homer Simpson'), findsWidgets);
    expect(find.text('Marge Simpson'), findsWidgets);
  });

  testWidgets('MyHomePage filters the list of characters when searching', (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(
        overrides: providerOverrides,
        child:MyApp()));

    await tester.enterText(find.byType(TextField), 'Homer');
    await tester.pump();

    await tester.pumpAndSettle();
    expect(find.text('Homer Simpson'), findsWidgets);
    expect(find.text('Marge Simpson'), findsNothing);
  });

  testWidgets('MyHomePage navigates to CharacterDetailPage when tapping on a character', (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(
        overrides: providerOverrides,
        child:MyApp()));

    await tester.pumpAndSettle();
    await tester.tap(find.text('Homer Simpson').first);
    await tester.pumpAndSettle();

    expect(find.byType(CharacterDetailPage), findsOneWidget);
  });
}
