import 'package:character_viewer/features/home/domain/character.dart';
import 'package:flutter/material.dart';

class CharacterDetailPage extends StatelessWidget {
  final Character character;

  const CharacterDetailPage(this.character, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(character.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            character.imageUrl.isNotEmpty
                ? Image.network('https://duckduckgo.com/${character.imageUrl}')
                : const Icon(
                    Icons.error_outline_sharp,
                    size: 50.0,
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(character.description),
            ),
          ],
        ),
      ),
    );
  }
}
