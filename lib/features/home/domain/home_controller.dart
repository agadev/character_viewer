import 'package:character_viewer/features/home/domain/character.dart';
import 'package:character_viewer/features/home/data/character_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeControllerProvider =
    StateNotifierProvider<HomeController, AsyncValue<HomeState>>((ref) {
  final charactersRepository = ref.read(charactersRepositoryProvider);
  return HomeController(charactersRepository);
});

class HomeController extends StateNotifier<AsyncValue<HomeState>> {
  final CharactersRepository characterRepository;

  HomeController(this.characterRepository,{AsyncValue<HomeState>? state}) : super(state ?? const AsyncValue.loading()) {
    _loadCharacters();
  }

  Future<void> _loadCharacters() async {
    state = const AsyncValue.loading();
    try {
      final characters = await characterRepository.getCharacters();
      state = AsyncValue.data(HomeState(allCharacters: characters));
    } catch (e, s) {
      state = AsyncValue.error(e);
    }
  }

  void search(String query) {
    state.whenData((state) {
      final filteredCharacters = state.allCharacters
          .where((character) =>
              character.title.toLowerCase().contains(query.toLowerCase()) ||
              character.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
      this.state = AsyncValue.data(
          state.copyWith(filteredCharacters: filteredCharacters,
              selectedIndex: filteredCharacters.length>0 ? 0:-1));
    });
  }

  void setSelectedCharacter(int newIndex) async {
    state.whenData((state) {
      this.state = AsyncValue.data(state.copyWith(selectedIndex: newIndex));
    });
  }
}

class HomeState {
  final List<Character> allCharacters;
  final List<Character> filteredCharacters;
  final int selectedIndex;
  HomeState({
    required this.allCharacters,
    List<Character>? filteredCharacters,
    this.selectedIndex =0,
  }) : filteredCharacters = filteredCharacters ?? allCharacters;

  HomeState copyWith({
    List<Character>? allCharacters,
    List<Character>? filteredCharacters,
    int? selectedIndex,
  }) {
    return HomeState(
        allCharacters: allCharacters ?? this.allCharacters,
        filteredCharacters: filteredCharacters ?? this.filteredCharacters,
        selectedIndex: selectedIndex ?? this.selectedIndex);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeState &&
          runtimeType == other.runtimeType &&
          allCharacters == other.allCharacters &&
          filteredCharacters == other.filteredCharacters &&
          selectedIndex == other.selectedIndex;

  @override
  int get hashCode =>
      allCharacters.hashCode ^
      filteredCharacters.hashCode ^
      selectedIndex.hashCode;
}
