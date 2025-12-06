import 'package:fav_coffee/theme/theme.dart';
import 'package:flutter/material.dart';

class RandomCoffeeActionButtonsWidget extends StatelessWidget {
  const RandomCoffeeActionButtonsWidget({
    required this.onDislikeTap,
    required this.onLikeTap,
    this.isEnabled = true,
    super.key,
  });

  final VoidCallback onDislikeTap;
  final VoidCallback onLikeTap;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _ActionButton(
        color: CoffeeColors.error,
        icon: Icons.heart_broken,
        isEnabled: isEnabled,
        onTap: onDislikeTap,
      ),
      const SizedBox(width: CoffeeSpacing.large),
      _ActionButton(
        color: CoffeeColors.success,
        icon: Icons.favorite,
        isEnabled: isEnabled,
        onTap: onLikeTap,
      ),
    ],
  );
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.color,
    required this.icon,
    required this.onTap,
    this.isEnabled = true,
  });

  final Color color;
  final IconData icon;
  final bool isEnabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = isEnabled ? color : CoffeeColors.disabled;

    return InkWell(
      onTap: isEnabled ? onTap : null,
      borderRadius: BorderRadius.circular(CoffeeSpacing.xxxlarge),
      child: Container(
        height: CoffeeSpacing.xxxlarge,
        width: CoffeeSpacing.xxxlarge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(CoffeeSpacing.xxxlarge),
          border: Border.all(
            color: effectiveColor,
          ),
        ),
        child: Icon(
          icon,
          color: effectiveColor,
        ),
      ),
    );
  }
}
