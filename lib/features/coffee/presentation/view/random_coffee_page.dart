import 'package:fav_coffee/features/coffee/presentation/presentation.dart';
import 'package:fav_coffee/l10n/l10n.dart';
import 'package:fav_coffee/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class RandomCoffeePage extends StatelessWidget {
  const RandomCoffeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RandomCoffeeCubit>(
      create: (_) {
        return GetIt.instance.get<RandomCoffeeCubit>()..initialize();
      },
      child: _RandomCoffeeView(
        () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const FavoriteCoffeePage(),
          ),
        ),
      ),
    );
  }
}

class _RandomCoffeeView extends StatelessWidget {
  const _RandomCoffeeView(this.onGoToFavorite);

  final VoidCallback onGoToFavorite;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(CoffeeSpacing.medium),
        child: Column(
          children: [
            TextButton(
              onPressed: onGoToFavorite,
              child: Text(context.l10n.randomImageGoToFavoriteText),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: CoffeeSpacing.small,
                ),
                child: BlocBuilder<RandomCoffeeCubit, RandomCoffeeState>(
                  builder: (context, state) => RandomCoffeeImageCardWidget(
                    state: state,
                    onRetry: () =>
                        context.read<RandomCoffeeCubit>().getRandomImage(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: CoffeeSpacing.small),
              child: BlocBuilder<RandomCoffeeCubit, RandomCoffeeState>(
                builder: (context, state) => RandomCoffeeActionButtonsWidget(
                  onDislikeTap: () =>
                      context.read<RandomCoffeeCubit>().getRandomImage(),
                  onLikeTap: () =>
                      context.read<RandomCoffeeCubit>().favoriteImage(),
                  isEnabled: state is SuccessRandomCoffeeState,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
