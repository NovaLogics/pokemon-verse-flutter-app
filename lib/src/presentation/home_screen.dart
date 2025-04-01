import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemonverse/src/core/favorite_pokemon_provider.dart';
import 'package:pokemonverse/src/data/models/page_data.dart';
import 'package:pokemonverse/src/data/models/pokemon.dart';
import 'package:pokemonverse/src/presentation/home_controller.dart';
import 'package:pokemonverse/src/presentation/pokemon_card.dart';
import 'package:pokemonverse/src/presentation/pokemon_list_tile.dart';

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
  final ScrollController _pokemonListScrollController = ScrollController();
  late HomeController _homeController;
  late HomePageData _homePageData;
  late List<String> _favoritePokemons = [];

  @override
  void initState() {
    super.initState();
    _pokemonListScrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _pokemonListScrollController.removeListener(_scrollListener);
    _pokemonListScrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_pokemonListScrollController.offset >=
            _pokemonListScrollController.position.maxScrollExtent * 1 &&
        !_pokemonListScrollController.position.outOfRange) {
      _homeController.loadPokemons();
    }
  }

  @override
  Widget build(BuildContext context) {
    _homeController = ref.watch(homeControllerProvider.notifier);
    _homePageData = ref.watch(homeControllerProvider);
    _favoritePokemons = ref.watch(favoritePokemonProvider);
    return Scaffold(body: _buildUI(context));
  }

  Widget _buildUI(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.02,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _favoritePokemonsList(context),
              _allPokemonsList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _allPokemonsList(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("All Pokemons", style: TextStyle(fontSize: 25)),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.60,
            child: ListView.builder(
              controller: _pokemonListScrollController,
              itemCount: _homePageData.data?.results?.length ?? 0,
              itemBuilder: (context, index) {
                PokemonListResult pokemonResult =
                    _homePageData.data!.results![index];
                return PokemonListTile(pokemonURL: pokemonResult.url!);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _favoritePokemonsList(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Favorite Pokemons", style: TextStyle(fontSize: 25)),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (_favoritePokemons.isNotEmpty)
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.48,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: _favoritePokemons.length,
                      itemBuilder: (context, index) {
                        return PokemonCard(
                          pokemonUrl: _favoritePokemons[index],
                        );
                      },
                    ),
                  ),
                if (_favoritePokemons.isEmpty)
                  const Text("No favorite pokemons yet!"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
