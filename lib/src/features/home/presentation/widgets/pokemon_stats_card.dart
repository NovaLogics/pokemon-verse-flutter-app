import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemonverse/src/core/providers/pokemon_data_provider.dart';

class PokemonStatsCard extends ConsumerWidget {
  final String pokemonUrl;

  const PokemonStatsCard({super.key, required this.pokemonUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemon = ref.watch(pokemonDataProvider(pokemonUrl));

    return AlertDialog(
      title: const Text("Pokémon Stats"),
      content: pokemon.when(
        data: (data) {
          if (data?.stats == null || data!.stats!.isEmpty) {
            return const Text("No stats available.");
          }
          return SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: data.stats!.map((element) {
                  return Text(
                    "${element.stat?.name?.toUpperCase()}: ${element.baseStat}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  );
                }).toList(),
              ),
            ),
          );
        },
        error: (error, stackTrace) {
          return Center(child: Text("Error: $error"));
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Close"),
        ),
      ],
    );
  }
}
