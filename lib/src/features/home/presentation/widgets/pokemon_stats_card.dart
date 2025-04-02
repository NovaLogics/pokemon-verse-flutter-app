import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemonverse/src/core/providers/pokemon_data_provider.dart';

class PokemonStatsCard extends ConsumerWidget {
  final String pokemonUrl;

  PokemonStatsCard({super.key, required this.pokemonUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemon = ref.watch(pokemonDataProvider(pokemonUrl));
    return AlertDialog(
      title: Text("Pokemon Stats"),
      content: pokemon.when(
        data: (data) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children:
                data?.stats?.map((elements) {
                  return Text(
                    "${elements.stat?.name?.toUpperCase()}: ${elements.baseStat} ",
                  );
                }).toList() ??
                [],
          );
        },
        error: (error, stackTrace) {
          return Center(child: Text("Error: $error"));
        },
        loading: () {
          return const CircularProgressIndicator(color: Colors.white);
        },
      ),
    );
  }
}
