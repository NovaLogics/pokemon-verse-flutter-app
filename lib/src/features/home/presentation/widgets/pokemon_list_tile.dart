import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemonverse/src/core/providers/favorite_pokemon_provider.dart';
import 'package:pokemonverse/src/core/providers/pokemon_data_provider.dart';
import 'package:pokemonverse/src/features/home/data/models/pokemon.dart';
import 'package:pokemonverse/src/features/home/presentation/widgets/pokemon_stats_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemonListTile extends ConsumerWidget {
  final String pokemonURL;

  const PokemonListTile({super.key, required this.pokemonURL});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritePokemonNotifier = ref.watch(favoritePokemonProvider.notifier);
    final favoritePokemons = ref.watch(favoritePokemonProvider);
    final pokemon = ref.watch(pokemonDataProvider(pokemonURL));

    return pokemon.when(
      data: (data) => _tile(context, favoritePokemonNotifier, favoritePokemons, false, data),
      error: (error, stackTrace) => Center(child: Text("Error: $error")),
      loading: () => _tile(context, favoritePokemonNotifier, favoritePokemons, true, null),
    );
  }

  Widget _tile(BuildContext context, FavoritePokemonNotifier favoritePokemonNotifier,
      List<String> favoritePokemons, bool isLoading, Pokemon? pokemon) {
    final bool isFavorite = favoritePokemons.contains(pokemonURL);

    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onTap: () {
          if (!isLoading) {
            showDialog(
              context: context,
              builder: (_) => PokemonStatsCard(pokemonUrl: pokemonURL),
            );
          }
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: pokemon?.sprites?.frontDefault != null
                ? NetworkImage(pokemon!.sprites!.frontDefault!)
                : null,
            backgroundColor: Colors.grey.shade300, 
          ),
          title: Text(
            pokemon?.name?.toUpperCase() ?? "Loading...",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text("Has ${pokemon?.moves?.length.toString() ?? '0'} moves"),
          trailing: IconButton(
            onPressed: () {
              isFavorite
                  ? favoritePokemonNotifier.removeFavoritePokemon(pokemonURL)
                  : favoritePokemonNotifier.addFavoritePokemon(pokemonURL);
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
