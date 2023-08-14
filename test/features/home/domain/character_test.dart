import 'package:character_viewer/features/home/domain/character.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Character', () {
    test('fromJson creates a Character from JSON data', () {
      final json = {
        'FirstURL': 'https://example.com/Homer_Simpson',
        'Text': 'Homer Simpson is a fictional character',
        'Icon': {'URL': 'https://example.com/homer.png'}
      };
      final character = Character.fromJson(json);

      expect(character.title, 'Homer Simpson');
      expect(character.description, 'Homer Simpson is a fictional character');
      expect(character.imageUrl, 'https://example.com/homer.png');
    });

    test('toJson returns JSON data from a Character', () {
      final character = Character(
        title: 'Homer Simpson',
        description: 'Homer Simpson is a fictional character',
        imageUrl: 'https://example.com/homer.png',
      );
      final json = character.toJson();

      expect(json['FirstURL'], 'Homer Simpson');
      expect(json['Text'], 'Homer Simpson is a fictional character');
      expect(json['Icon'], 'https://example.com/homer.png');
    });
  });

  group('IconRes', () {
    test('fromJson creates an IconRes from JSON data', () {
      final json = {'Height': '100', 'URL': 'https://example.com/homer.png', 'Width': '100'};
      final iconRes = IconRes.fromJson(json);

      expect(iconRes.height, '100');
      expect(iconRes.url, 'https://example.com/homer.png');
      expect(iconRes.width, '100');
    });

    test('toJson returns JSON data from an IconRes', () {
      final iconRes = IconRes(
        height: '100',
        url: 'https://example.com/homer.png',
        width: '100',
      );
      final json = iconRes.toJson();

      expect(json['Height'], '100');
      expect(json['URL'], 'https://example.com/homer.png');
      expect(json['Width'], '100');
    });
  });
}
