import 'dart:typed_data';

import 'package:fav_coffee/features/coffee/presentation/presentation.dart';
import 'package:fav_coffee/features/shared/presentation/widgets/memory_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/helpers.dart';

void main() {
  group('FavoriteCoffeeImageCardWidget', () {
    final fakeImageBytes = Uint8List.fromList([
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
    ]);

    testWidgets('displays Card with MemoryImageWidget', (
      WidgetTester tester,
    ) async {
      await tester.pumpAppWidget(
        FavoriteCoffeeImageCardWidget(
          fakeImageBytes,
          onImageTap: () {},
        ),
      );
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(MemoryImageWidget), findsOneWidget);
    });

    testWidgets('displays Hero widget with correct tag', (
      WidgetTester tester,
    ) async {
      const heroTag = 'coffee_hero_1';
      await tester.pumpAppWidget(
        FavoriteCoffeeImageCardWidget(
          fakeImageBytes,
          onImageTap: () {},
          heroTag: heroTag,
        ),
      );
      final heroWidget = find.byType(Hero).evaluate().first.widget as Hero;
      expect(heroWidget.tag, heroTag);
    });

    testWidgets('onImageTap callback is triggered when tapped', (
      WidgetTester tester,
    ) async {
      var tapped = false;
      await tester.pumpAppWidget(
        FavoriteCoffeeImageCardWidget(
          fakeImageBytes,
          onImageTap: () {
            tapped = true;
          },
        ),
      );
      await tester.tap(find.byType(InkWell));
      expect(tapped, true);
    });

    testWidgets('uses default empty heroTag when not provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpAppWidget(
        FavoriteCoffeeImageCardWidget(
          fakeImageBytes,
          onImageTap: () {},
        ),
      );
      final heroWidget = find.byType(Hero).evaluate().first.widget as Hero;
      expect(heroWidget.tag, '');
    });
  });
}
