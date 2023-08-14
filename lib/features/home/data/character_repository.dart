import 'dart:convert';
import 'package:character_viewer/features/home/domain/character.dart';
import 'package:dio/dio.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider((ref) => Dio());
final charactersRepositoryProvider = Provider((ref) => CharactersRepository(ref.read));
final apiUrlProvider = Provider<String>((ref) => FlavorConfig.instance.variables["apiUrl"]);

class CharactersRepository {
  final Reader read;
  CharactersRepository(this.read);

  Future<List<Character>> getCharacters() async {
    final dio = read(dioProvider);
    final String apiUrl = read(apiUrlProvider);
    final response = await dio.get(apiUrl);
    print("resonse.data: " + response.data);
    final characters = (json.decode(response.data)['RelatedTopics'] as List)
        .map((e) => Character.fromJson(e))
        .toList();
    return characters;
  }
}
