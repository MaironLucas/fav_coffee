import 'package:fav_coffee/features/coffee/domain/models/models.dart';
import 'package:fav_coffee/features/coffee/presentation/presentation.dart';
import 'package:fav_coffee/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/helpers.dart';

void main() {
  group('FavoriteCoffeeDetailsPage', () {
    final fakeCoffeeImage = CoffeeImage(
      id: '1',
      bytes: Uint8List.fromList([
        0x89,
        0x50,
        0x4E,
        0x47,
        0x0D,
        0x0A,
        0x1A,
        0x0A,
        0x00,
        0x00,
        0x00,
        0x0D,
        0x49,
        0x48,
        0x44,
        0x52,
        0x00,
        0x00,
        0x00,
        0x01,
        0x00,
        0x00,
        0x00,
        0x01,
        0x08,
        0x06,
        0x00,
        0x00,
        0x00,
        0x1F,
        0x15,
        0xC4,
        0x89,
        0x00,
        0x00,
        0x00,
        0x0D,
        0x49,
        0x44,
        0x41,
        0x54,
        0x08,
        0x99,
        0x63,
        0xF8,
        0x0F,
        0x00,
        0x00,
        0x01,
        0x01,
        0x00,
        0x00,
        0x18,
        0xDD,
        0x8D,
        0xB4,
        0x00,
        0x00,
        0x00,
        0x00,
        0x49,
        0x45,
        0x4E,
        0x44,
        0xAE,
        0x42,
        0x60,
        0x82,
      ]),
    );

    testWidgets('displays app bar with coffee image id', (
      WidgetTester tester,
    ) async {
      await tester.pumpAppPage(
        FavoriteCoffeeDetailsPage(coffeeImage: fakeCoffeeImage),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text(fakeCoffeeImage.id), findsOneWidget);
    });

    testWidgets('displays MemoryImageWidget', (
      WidgetTester tester,
    ) async {
      await tester.pumpAppPage(
        FavoriteCoffeeDetailsPage(coffeeImage: fakeCoffeeImage),
      );

      expect(find.byType(MemoryImageWidget), findsOneWidget);
    });

    testWidgets('wraps image with Hero animation using coffee id as tag', (
      WidgetTester tester,
    ) async {
      await tester.pumpAppPage(
        FavoriteCoffeeDetailsPage(coffeeImage: fakeCoffeeImage),
      );

      final heroFinder = find.byType(Hero);
      expect(heroFinder, findsOneWidget);

      final hero = tester.widget<Hero>(heroFinder);
      expect(hero.tag, equals(fakeCoffeeImage.id));
    });
  });
}
