import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemonverse/src/app.dart';
import 'package:pokemonverse/src/core/services/database_service.dart';
import 'package:pokemonverse/src/core/services/http_service.dart';

void main() async {
  await _setupServices();

  _launchApp();
}

Future<void> _setupServices() async {
  GetIt.instance.registerSingleton<HttpService>(HttpService());
  GetIt.instance.registerSingleton<DatabaseService>(DatabaseService());
}

void _launchApp() {
  runApp(const PokemonVerseApp());
}
