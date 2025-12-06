import 'package:fav_coffee/features/coffee/presentation/presentation.dart';
import 'package:fav_coffee/l10n/l10n.dart';
import 'package:fav_coffee/theme/theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: const CoffeeTheme().themeData,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const RandomCoffeePage(),
    );
  }
}
