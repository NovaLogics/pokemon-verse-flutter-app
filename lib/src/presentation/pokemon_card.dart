import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemonverse/src/core/favorite_pokemon_provider.dart';
import 'package:pokemonverse/src/core/pokemon_data_provider.dart';
import 'package:pokemonverse/src/data/models/pokemon.dart';
import 'package:pokemonverse/src/presentation/pokemon_stats_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemonCard extends ConsumerWidget {
  final String pokemonUrl;
  late FavoritePokemonProvider _favoritePokemonProvider;

  PokemonCard({super.key, required this.pokemonUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _favoritePokemonProvider = ref.watch(favoritePokemonProvider.notifier);
    final pokemon = ref.watch(pokemonDataProvider(pokemonUrl));

    return pokemon.when(
      data: (data) {
        return _card(context, false, data);
      },
      error: (error, stackTrace) {
        return Center(child: Text("Error: $error"));
      },
      loading: () {
        return _card(context, true, null);
      },
    );
  }

  Widget _card(BuildContext context, bool isLoading, Pokemon? pokemon) {
    return Skeletonizer(
      enabled: isLoading,
      ignoreContainers: true,
      child: GestureDetector(
        onTap: () {
          if (!isLoading) {
            showDialog(context: context, builder: (_){ return PokemonStatsCard(pokemonUrl: pokemonUrl); });
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.03,
            vertical: MediaQuery.sizeOf(context).height * 0.01,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.03,
            vertical: MediaQuery.sizeOf(context).height * 0.01,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).primaryColor,
            boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 2),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    pokemon != null ? pokemon.name!.toUpperCase() : "Pokemon",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "#${pokemon?.id.toString() ?? 0}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: CircleAvatar(
                  backgroundImage:
                      pokemon != null
                          ? NetworkImage(pokemon.sprites!.frontDefault!)
                          : null,
                  radius: MediaQuery.sizeOf(context).height * 0.05,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${pokemon?.moves?.length.toString() ?? 0} moves",
                    style: const TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      _favoritePokemonProvider.removeFavoritePokemon(
                        pokemonUrl,
                      );
                    },
                    child: Icon(Icons.favorite, color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
