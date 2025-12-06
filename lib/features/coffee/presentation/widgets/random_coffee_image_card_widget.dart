import 'package:fav_coffee/features/coffee/presentation/presentation.dart';
import 'package:fav_coffee/features/shared/shared.dart';
import 'package:fav_coffee/l10n/l10n.dart';
import 'package:flutter/material.dart';

class RandomCoffeeImageCardWidget extends StatelessWidget {
  const RandomCoffeeImageCardWidget({
    required this.state,
    required this.onRetry,
    super.key,
  });

  final RandomCoffeeState state;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Card(
    child: switch (state) {
      LoadingRandomCoffeeState() => const Center(
        child: CircularProgressIndicator(),
      ),
      SuccessRandomCoffeeState(coffeeImage: final coffeeImage) =>
        MemoryImageWidget(
          coffeeImage.bytes,
          width: double.infinity,
        ),
      ErrorRandomCoffeeState() => ErrorIndicatorWidget(
        message: context.l10n.randomImageErrorText,
        onRetry: onRetry,
      ),
    },
  );
}
