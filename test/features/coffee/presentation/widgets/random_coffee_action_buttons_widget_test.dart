import 'package:fav_coffee/features/coffee/presentation/presentation.dart';
import 'package:fav_coffee/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/helpers.dart';

void main() {
  group('RandomCoffeeActionButtonsWidget', () {
    testWidgets('renders two action buttons', (WidgetTester tester) async {
      await tester.pumpAppWidget(
        RandomCoffeeActionButtonsWidget(
          onDislikeTap: () {},
          onLikeTap: () {},
        ),
      );

      expect(find.byType(InkWell), findsNWidgets(2));
      expect(find.byIcon(Icons.heart_broken), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });

    testWidgets('calls onDislikeTap when heart_broken button is tapped', (
      WidgetTester tester,
    ) async {
      var dislikeTapped = false;
      await tester.pumpAppWidget(
        RandomCoffeeActionButtonsWidget(
          onDislikeTap: () => dislikeTapped = true,
          onLikeTap: () {},
        ),
      );

      await tester.tap(find.byIcon(Icons.heart_broken));
      expect(dislikeTapped, isTrue);
    });

    testWidgets('calls onLikeTap when favorite button is tapped', (
      WidgetTester tester,
    ) async {
      var likeTapped = false;
      await tester.pumpAppWidget(
        RandomCoffeeActionButtonsWidget(
          onDislikeTap: () {},
          onLikeTap: () => likeTapped = true,
        ),
      );

      await tester.tap(find.byIcon(Icons.favorite));
      expect(likeTapped, isTrue);
    });

    testWidgets('buttons are disabled when isEnabled is false', (
      WidgetTester tester,
    ) async {
      var dislikeTapped = false;
      var likeTapped = false;
      await tester.pumpAppWidget(
        RandomCoffeeActionButtonsWidget(
          onDislikeTap: () => dislikeTapped = true,
          onLikeTap: () => likeTapped = true,
          isEnabled: false,
        ),
      );

      await tester.tap(find.byIcon(Icons.heart_broken));
      await tester.tap(find.byIcon(Icons.favorite));
      expect(dislikeTapped, isFalse);
      expect(likeTapped, isFalse);

      final heartBrokenIcon = tester.widget<Icon>(
        find.byIcon(Icons.heart_broken),
      );
      final favoriteIcon = tester.widget<Icon>(find.byIcon(Icons.favorite));
      expect(heartBrokenIcon.color, CoffeeColors.disabled);
      expect(favoriteIcon.color, CoffeeColors.disabled);
    });
  });
}
