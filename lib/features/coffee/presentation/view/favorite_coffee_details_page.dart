import 'package:fav_coffee/features/coffee/domain/domain.dart';
import 'package:fav_coffee/features/shared/shared.dart';
import 'package:flutter/material.dart';

class FavoriteCoffeeDetailsPage extends StatelessWidget {
  const FavoriteCoffeeDetailsPage({required this.coffeeImage, super.key});

  final CoffeeImage coffeeImage;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(coffeeImage.id),
    ),
    body: Center(
      child: Hero(
        tag: coffeeImage.id,
        child: MemoryImageWidget(coffeeImage.bytes),
      ),
    ),
  );
}
