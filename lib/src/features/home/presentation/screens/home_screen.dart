import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemonverse/src/core/providers/favorite_pokemon_provider.dart';
import 'package:pokemonverse/src/features/home/data/models/page_data.dart';
import 'package:pokemonverse/src/features/home/presentation/controller/home_controller.dart';
import 'package:pokemonverse/src/features/home/presentation/widgets/pokemon_card.dart';
import 'package:pokemonverse/src/features/home/presentation/widgets/pokemon_list_tile.dart';

// Provider for HomeController state management
final homeControllerProvider =
    StateNotifierProvider<HomeController, HomePageData>((ref) {
  return HomeController(HomePageData.initial());
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

  // Detects when the user reaches the end of the list and loads more Pokémon
  void _onScroll() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
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
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFavoritePokemonsList(context, favoritePokemons),
              _buildAllPokemonsList(context, homePageData),
            ],
          ),
        ),
      ),
    );
  }

  // Builds the list of all Pokémon
  Widget _buildAllPokemonsList(BuildContext context, HomePageData homePageData) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("All Pokémon", style: TextStyle(fontSize: 25)),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: homePageData.data?.results?.length ?? 0,
              itemBuilder: (context, index) {
                final pokemon = homePageData.data!.results![index];
                return PokemonListTile(pokemonURL: pokemon.url!);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Builds the list of favorite Pokémon
  Widget _buildFavoritePokemonsList(BuildContext context, List<String> favoritePokemons) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Favorite Pokémon", style: TextStyle(fontSize: 25)),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.50,
          child: favoritePokemons.isNotEmpty
              ? GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: favoritePokemons.length,
                  itemBuilder: (context, index) {
                    return PokemonCard(
                      pokemonUrl: favoritePokemons[index],
                    );
                  },
                )
              : const Center(child: Text("No favorite Pokémons yet!")),
        ),
      ],
    );
  }
}
