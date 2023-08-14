import 'package:character_viewer/features/home/data/character_repository.dart';
import 'package:character_viewer/features/home/domain/home_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../common_data.dart';

class MockCharacterRepository extends Mock implements CharactersRepository {}

void main() {
  test('HomeController loads a list of characters', () async {
    final charactersRepository = MockCharacterRepository();
    when(() => charactersRepository.getCharacters()).thenAnswer((_) {
      return Future.value(fakeCharactersList);
    });

    final container = ProviderContainer(overrides: [
      charactersRepositoryProvider.overrideWithValue(charactersRepository),
    ]);

    final controller = container.read(homeControllerProvider.notifier);
    await Future.delayed(Duration.zero);
    final state = container.read(homeControllerProvider);

    expect(state, isA<AsyncValue<HomeState>>());
    state.whenData((state) {
      expect(state.filteredCharacters.length, 2);
      expect(state.filteredCharacters[0].title, 'Homer Simpson');
      expect(state.filteredCharacters[0].description,
          'Homer Simpson is a fictional character and the main protagonist of the American animated sitcom The Simpsons.');
      expect(
          state.filteredCharacters[0].imageUrl, '/i/www.simpsonsworld.com.ico');
    });
  });

  test('HomeController filters the list of characters when searching',
      () async {
    final charactersRepository = MockCharacterRepository();
    when(() => charactersRepository.getCharacters()).thenAnswer((_) {
      return Future.value(fakeCharactersList);
    });

    final container = ProviderContainer(overrides: [
      charactersRepositoryProvider.overrideWithValue(charactersRepository),
    ]);

    final controller = container.read(homeControllerProvider.notifier);
    await Future.delayed(Duration.zero);
    controller.search('Homer');
    await Future.delayed(Duration.zero);
    final state = container.read(homeControllerProvider);

    expect(state, isA<AsyncValue<HomeState>>());
    state.whenData((state) {
      expect(state.filteredCharacters.length, 1);
      expect(state.filteredCharacters[0].title, 'Homer Simpson');
      expect(state.filteredCharacters[0].description,
          'Homer Simpson is a fictional character and the main protagonist of the American animated sitcom The Simpsons.');
      expect(
          state.filteredCharacters[0].imageUrl, '/i/www.simpsonsworld.com.ico');
    });
  });
}
