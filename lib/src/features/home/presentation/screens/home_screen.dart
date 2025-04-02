import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemonverse/src/core/providers/favorite_pokemon_provider.dart';
import 'package:pokemonverse/src/features/home/presentation/controller/home_controller.dart';
import 'package:pokemonverse/src/features/home/presentation/controller/home_data_state.dart';
import 'package:pokemonverse/src/features/home/presentation/widgets/pokemon_card.dart';
import 'package:pokemonverse/src/features/home/presentation/widgets/pokemon_list_tile.dart';

// Provider for HomeController state management
final homeControllerProvider =
    StateNotifierProvider<HomeController, HomeDataState>((ref) {
      return HomeController(HomeDataState.initial());
    });

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  late HomeController _homeController;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  // Detects when the user reaches the end of the scrollable list and loads more Pokémon
  void _onScroll() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _homeController.loadPokemons();
    }
  }

  @override
  Widget build(BuildContext context) {
    _homeController = ref.watch(homeControllerProvider.notifier);
    final homePageData = ref.watch(homeControllerProvider);
    final favoritePokemons = ref.watch(favoritePokemonProvider);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Favorite Pokémon section
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * 0.02,
                ),
                child: _buildFavoritePokemonsList(context, favoritePokemons),
              ),
            ),
            // Title for All Pokémon section
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * 0.02,
                  vertical: 8.0,
                ),
                child: const Text(
                  "All Pokémon",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            // All Pokémon list using a SliverList
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final pokemon = homePageData.data!.results![index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.02,
                  ),
                  child: PokemonListTile(pokemonURL: pokemon.url!),
                );
              }, childCount: homePageData.data?.results?.length ?? 0),
            ),
          ],
        ),
      ),
    );
  }

  // Builds the list of favorite Pokémon
  Widget _buildFavoritePokemonsList(
    BuildContext context,
    List<String> favoritePokemons,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Favorite Pokémon", style: TextStyle(fontSize: 25)),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.50,
          child:
              favoritePokemons.isNotEmpty
                  ? GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                    itemCount: favoritePokemons.length,
                    itemBuilder: (context, index) {
                      return PokemonCard(pokemonUrl: favoritePokemons[index]);
                    },
                  )
                  : const Center(child: Text("No favorite Pokémons yet!")),
        ),
      ],
    );
  }
}
