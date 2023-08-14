import 'package:character_viewer/features/home/domain/home_controller.dart';
import 'package:character_viewer/features/home/ui/character_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appTitleProvider = Provider<String>((ref) => FlavorConfig.instance.variables["appTitle"]);

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    return Consumer(builder: (context, ref, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(ref.read(appTitleProvider)),
        ),
        body: isTablet
            ? Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Consumer(builder: (context, ref, child) {
                            return TextField(
                              controller: _searchController,
                              decoration: const InputDecoration(
                                labelText: 'Search',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) => ref
                                  .read(homeControllerProvider.notifier)
                                  .search(value),
                            );
                          }),
                        ),
                        Expanded(
                          child: Consumer(builder: (context, ref, child) {
                            final state = ref.watch(homeControllerProvider);
                            return state.when(
                              data: (state) => ListView.builder(
                                itemCount: state.filteredCharacters.length,
                                itemBuilder: (context, index) {
                                  final character =
                                      state.filteredCharacters[index];
                                  return ListTile(
                                    title: Text(character.title),
                                    onTap: () {
                                      ref
                                          .read(homeControllerProvider.notifier)
                                          .setSelectedCharacter(index);
                                    },
                                  );
                                },
                              ),
                              loading: () => const Center(
                                  child: CircularProgressIndicator()),
                              error: (e, s) =>
                                  const Center(child: Text('Error')),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Consumer(builder: (context, ref, child) {
                      final state = ref.watch(homeControllerProvider);
                      return state.when(
                        data: (state) => state.filteredCharacters.length>0 ? CharacterDetailPage(
                          state.filteredCharacters[state.selectedIndex],
                        ): Container(),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (e, s) => const Center(child: Text('Error')),
                      );
                    }),
                  ),
                ],
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer(builder: (context, ref, child) {
                      return TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          labelText: 'Search',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => ref
                            .read(homeControllerProvider.notifier)
                            .search(value),
                      );
                    }),
                  ),
                  Expanded(
                    child: Consumer(builder: (context, ref, child) {
                      final state = ref.watch(homeControllerProvider);
                      return state.when(
                        data: (state) => ListView.builder(
                          itemCount: state.filteredCharacters.length,
                          itemBuilder: (context, index) {
                            final character = state.filteredCharacters[index];
                            return ListTile(
                              title: Text(character.title),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CharacterDetailPage(character)),
                              ),
                            );
                          },
                        ),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (e, s) => const Center(child: Text('Error')),
                      );
                    }),
                  ),
                ],
              ),
      );
    });
  }
}
