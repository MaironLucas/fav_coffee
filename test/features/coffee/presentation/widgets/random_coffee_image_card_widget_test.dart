import 'dart:typed_data';

import 'package:fav_coffee/features/coffee/domain/domain.dart';
import 'package:fav_coffee/features/coffee/presentation/presentation.dart';
import 'package:fav_coffee/features/shared/presentation/widgets/error_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/helpers.dart';

void main() {
  group('RandomCoffeeImageCardWidget', () {
    testWidgets('displays CircularProgressIndicator when loading', (
      WidgetTester tester,
    ) async {
      await tester.pumpAppWidget(
        RandomCoffeeImageCardWidget(
          state: LoadingRandomCoffeeState(),
          onRetry: () {},
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays Image.memory when success', (
      WidgetTester tester,
    ) async {
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
      await tester.pumpAppWidget(
        RandomCoffeeImageCardWidget(
          state: SuccessRandomCoffeeState(coffeeImage: fakeCoffeeImage),
          onRetry: () {},
        ),
      );
      expect(find.byType(Image), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('displays ErrorIndicatorWidget when error', (
      WidgetTester tester,
    ) async {
      await tester.pumpAppWidget(
        RandomCoffeeImageCardWidget(
          state: ErrorRandomCoffeeState(),
          onRetry: () {},
        ),
      );
      expect(find.byType(ErrorIndicatorWidget), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('onRetry callback is passed to ErrorIndicatorWidget', (
      WidgetTester tester,
    ) async {
      void onRetry() {}
      await tester.pumpAppWidget(
        RandomCoffeeImageCardWidget(
          state: ErrorRandomCoffeeState(),
          onRetry: onRetry,
        ),
      );
      final errorWidget =
          find.byType(ErrorIndicatorWidget).evaluate().first.widget
              as ErrorIndicatorWidget;
      expect(errorWidget.onRetry, onRetry);
    });
  });
}
