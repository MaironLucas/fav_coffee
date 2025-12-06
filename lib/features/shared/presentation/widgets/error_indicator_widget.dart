import 'package:fav_coffee/l10n/l10n.dart';
import 'package:fav_coffee/theme/theme.dart';
import 'package:flutter/material.dart';

class ErrorIndicatorWidget extends StatelessWidget {
  const ErrorIndicatorWidget({
    required this.message,
    required this.onRetry,
    super.key,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          message,
          textAlign: TextAlign.center,
          style: CoffeeTextStyles.labelLarge,
        ),
        const SizedBox(
          height: CoffeeSpacing.medium,
        ),
        TextButton(
          onPressed: onRetry,
          child: Text(
            context.l10n.tryAgainButtonText,
            style: CoffeeTextStyles.bodyMedium,
          ),
        ),
      ],
    ),
  );
}
