import 'dart:typed_data';

import 'package:fav_coffee/features/shared/shared.dart';
import 'package:flutter/material.dart';

class FavoriteCoffeeImageCardWidget extends StatelessWidget {
  const FavoriteCoffeeImageCardWidget(
    this.imageBytes, {
    required this.onImageTap,
    this.heroTag = '',
    super.key,
  });

  final Uint8List imageBytes;
  final VoidCallback onImageTap;
  final String heroTag;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onImageTap,
    child: Card(
      child: Hero(
        tag: heroTag,
        child: MemoryImageWidget(
          imageBytes,
        ),
      ),
    ),
  );
}
