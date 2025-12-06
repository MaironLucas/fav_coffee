import 'dart:typed_data';

import 'package:fav_coffee/l10n/l10n.dart';
import 'package:fav_coffee/theme/theme.dart';
import 'package:flutter/widgets.dart';

class MemoryImageWidget extends StatelessWidget {
  const MemoryImageWidget(this.imageBytes, {this.width, super.key});

  final Uint8List imageBytes;
  final double? width;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(CoffeeSpacing.medium),
    child: Image.memory(
      imageBytes,
      fit: BoxFit.cover,
      width: width,
      errorBuilder: (context, error, stackTrace) => Center(
        child: Text(
          context.l10n.memoryImageErrorText,
          style: CoffeeTextStyles.bodyMedium,
        ),
      ),
    ),
  );
}
