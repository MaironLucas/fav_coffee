import 'package:fav_coffee/features/coffee/domain/domain.dart';
import 'package:fav_coffee/features/coffee/presentation/presentation.dart';
import 'package:fav_coffee/features/shared/shared.dart';
import 'package:fav_coffee/l10n/l10n.dart';
import 'package:fav_coffee/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class FavoriteCoffeePage extends StatelessWidget {
  const FavoriteCoffeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoriteCoffeeCubit>(
      create: (_) {
        return GetIt.instance.get<FavoriteCoffeeCubit>()..initialize();
      },
      child: _FavoriteCoffeeView(
        (coffeeImage) => {},
      ),
    );
  }
}

class _FavoriteCoffeeView extends StatelessWidget {
  const _FavoriteCoffeeView(this.onImageSelected);

  final ValueChanged<CoffeeImage> onImageSelected;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(context.l10n.favoriteCoffeePageTitle),
    ),
    body: SafeArea(
      child: BlocBuilder<FavoriteCoffeeCubit, FavoriteCoffeeState>(
        builder: (context, state) => switch (state) {
          LoadingFavoriteCoffeeState() => const Center(
            child: CircularProgressIndicator(),
          ),
          SuccessFavoriteCoffeeState(favoriteImages: final favoriteImages)
              when favoriteImages.isEmpty =>
            Center(
              child: Text(
                context.l10n.favoriteCoffeePageEmptyText,
                style: CoffeeTextStyles.labelLarge,
              ),
            ),
          SuccessFavoriteCoffeeState(favoriteImages: final favoriteImages) =>
            GridView.builder(
              itemCount: favoriteImages.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: CoffeeSpacing.small,
                crossAxisSpacing: CoffeeSpacing.small,
              ),
              itemBuilder: (context, index) {
                final coffeeImage = favoriteImages[index];
                return FavoriteCoffeeImageCardWidget(
                  coffeeImage.bytes,
                  onImageTap: () => onImageSelected(coffeeImage),
                  heroTag: coffeeImage.id,
                );
              },
            ),
          ErrorFavoriteCoffeeState() => ErrorIndicatorWidget(
            message: context.l10n.favoriteCoffeePageErrorText,
            onRetry: () =>
                context.read<FavoriteCoffeeCubit>().getFavoriteCoffees(),
          ),
        },
      ),
    ),
  );
}
