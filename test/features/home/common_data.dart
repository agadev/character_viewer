import 'package:character_viewer/features/home/domain/character.dart';
import 'package:flutter_test/flutter_test.dart';

String fakeResponseData = '''
        {
          "RelatedTopics":
           [
            {
              "FirstURL": "https://duckduckgo.com/Homer_Simpson",
              "Text":
              "Homer Simpson is a fictional character and the main protagonist of the American animated sitcom The Simpsons.",
              "Icon": {"URL": "/i/www.simpsonsworld.com.ico"}
            },
            {
              "FirstURL": "https://duckduckgo.com/Marge_Simpson",
              "Text":
              "Marjorie Jacqueline Marge Simpson is a fictional character in the American animated sitcom The Simpsons and part of the eponymous family.",
              "Icon": {"URL": "/i/www.simpsonsworld.com.ico"}
            }
           ]
        }
        ''';

List<Character> fakeCharactersList = [
  Character(
    title: 'Homer Simpson',
    description:
    'Homer Simpson is a fictional character and the main protagonist of the American animated sitcom The Simpsons.',
    imageUrl: '/i/www.simpsonsworld.com.ico',
  ),
  Character(
    title: 'Marge Simpson',
    description:
    'Marjorie Jacqueline "Marge" Simpson is a fictional character in the American animated sitcom The Simpsons and part of the eponymous family.',
    imageUrl: '/i/www.simpsonsworld.com.ico',
  ),
];

List<Character> fakeCharactersListNoImage = [
  Character(
    title: 'Homer Simpson',
    description:
    'Homer Simpson is a fictional character and the main protagonist of the American animated sitcom The Simpsons.',
    imageUrl: '',
  ),
  Character(
    title: 'Marge Simpson',
    description:
    'Marjorie Jacqueline "Marge" Simpson is a fictional character in the American animated sitcom The Simpsons and part of the eponymous family.',
    imageUrl: '',
  ),
];

final futureFakeCharactersList = Future.value(fakeCharactersList);


