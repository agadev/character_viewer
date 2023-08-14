import 'package:character_viewer/features/home/data/character_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../common_data.dart';


class MockDio extends Mock implements Dio {}

void main() {
  test('CharacterRepository.getCharacters returns a list of characters',
      () async {
    final dio = MockDio();
    when(() => dio.get("any")).thenAnswer((_) {
        return Future.value(
            Response(
        data: fakeResponseData,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));
    });

    final container = ProviderContainer(overrides: [
      dioProvider.overrideWithValue(dio),
      apiUrlProvider.overrideWithValue("any"),
    ]);

    final characterRepository = container.read(charactersRepositoryProvider);
    final characters = await characterRepository.getCharacters();

    expect(characters.length, 2);
    expect(characters[0].title, 'Homer Simpson');
    expect(characters[0].description,
        'Homer Simpson is a fictional character and the main protagonist of the American animated sitcom The Simpsons.');
    expect(characters[0].imageUrl, '/i/www.simpsonsworld.com.ico');
  });
}
