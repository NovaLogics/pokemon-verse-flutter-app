import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemonverse/src/core/providers/favorite_pokemon_provider.dart';
import 'package:pokemonverse/src/core/providers/pokemon_data_provider.dart';
import 'package:pokemonverse/src/features/home/data/models/pokemon.dart';
import 'package:pokemonverse/src/features/home/presentation/widgets/pokemon_stats_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemonListTile extends ConsumerWidget {
  final String pokemonURL;

  late FavoritePokemonNotifier _favoritePokemonProvider;
  late List<String> _favoritePokemons;

  PokemonListTile({super.key, required this.pokemonURL});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _favoritePokemonProvider = ref.watch(favoritePokemonProvider.notifier);
    _favoritePokemons = ref.watch(favoritePokemonProvider);

    final pokemon = ref.watch(pokemonDataProvider(pokemonURL));

    return pokemon.when(
      data: (data) {
        return _tile(context, false, data);
      },
      error: (error, stackTrace) {
        return Center(child: Text("Error: $error"));
      },
      loading: () {
        return _tile(context, true, null);
      },
    );
  }

  Widget _tile(BuildContext context, bool isLoading, Pokemon? pokemon) {
    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onTap: () {
          if (!isLoading) {
            showDialog(
              context: context,
              builder: (_) {
                return PokemonStatsCard(pokemonUrl: pokemonURL);
              },
            );
          }
        },
        child: ListTile(
          leading:
              pokemon != null
                  ? CircleAvatar(
                    backgroundImage: NetworkImage(
                      pokemon.sprites!.frontDefault!,
                    ),
                  )
                  : CircleAvatar(),
          title: Text(
            pokemon != null ? pokemon.name!.toUpperCase() : "Loading...",
          ),
          subtitle: Text("Has ${pokemon?.moves?.length.toString() ?? 0} moves"),
          trailing: IconButton(
            onPressed: () {
              if (_favoritePokemons.contains(pokemonURL)) {
                _favoritePokemonProvider.removeFavoritePokemon(pokemonURL);
              } else {
                _favoritePokemonProvider.addFavoritePokemon(pokemonURL);
              }
            },
            icon: Icon(
              _favoritePokemons.contains(pokemonURL)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
