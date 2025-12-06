import 'package:fav_coffee/features/coffee/domain/models/models.dart';
import 'package:fav_coffee/features/coffee/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/helpers.dart';

class MockRandomCoffeeCubit extends Mock implements RandomCoffeeCubit {}

void main() {
  group('RandomCoffeePage', () {
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
    late RandomCoffeeCubit randomCoffeeCubit;

    setUp(() {
      randomCoffeeCubit = MockRandomCoffeeCubit();

      when(randomCoffeeCubit.close).thenAnswer((_) async {});

      registerFakeDependencies(
        randomCoffeeCubit: randomCoffeeCubit,
      );
    });

    tearDown(removeInstances);

    void mockState(RandomCoffeeState state) {
      when(() => randomCoffeeCubit.stream).thenAnswer(
        (_) => Stream.value(state),
      );
      when(() => randomCoffeeCubit.state).thenAnswer(
        (_) => state,
      );
    }

    testWidgets('initializes RandomCoffeeCubit and calls initialize', (
      WidgetTester tester,
    ) async {
      mockState(LoadingRandomCoffeeState());

      await tester.pumpAppPage(const RandomCoffeePage());

      verify(randomCoffeeCubit.initialize).called(1);
    });

    testWidgets('displays RandomCoffeeImageCardWidget when state is success', (
      WidgetTester tester,
    ) async {
      mockState(SuccessRandomCoffeeState(coffeeImage: fakeCoffeeImage));

      await tester.pumpAppPage(const RandomCoffeePage());

      expect(find.byType(RandomCoffeeImageCardWidget), findsOneWidget);
    });

    testWidgets('calls getRandomImage when dislike button is tapped', (
      WidgetTester tester,
    ) async {
      mockState(SuccessRandomCoffeeState(coffeeImage: fakeCoffeeImage));
      when(() => randomCoffeeCubit.getRandomImage()).thenAnswer((_) async {});

      await tester.pumpAppPage(const RandomCoffeePage());

      final dislikeButtonFinder = find.byIcon(
        Icons.heart_broken,
      );

      await tester.tap(dislikeButtonFinder);

      verify(
        () => randomCoffeeCubit.getRandomImage(),
      ).called(1);
    });

    testWidgets('calls favoriteImage when like button is tapped', (
      WidgetTester tester,
    ) async {
      mockState(SuccessRandomCoffeeState(coffeeImage: fakeCoffeeImage));
      when(() => randomCoffeeCubit.favoriteImage()).thenAnswer((_) async {});

      await tester.pumpAppPage(const RandomCoffeePage());

      final likeButtonFinder = find.byIcon(
        Icons.favorite,
      );

      await tester.tap(likeButtonFinder);

      verify(
        () => randomCoffeeCubit.favoriteImage(),
      ).called(1);
    });

    testWidgets('disables action buttons when state is loading', (
      WidgetTester tester,
    ) async {
      mockState(LoadingRandomCoffeeState());

      await tester.pumpAppPage(const RandomCoffeePage());

      final actionButtonsFinder = find.byType(RandomCoffeeActionButtonsWidget);
      final actionButtonsWidget = tester
          .widget<RandomCoffeeActionButtonsWidget>(
            actionButtonsFinder,
          );

      expect(actionButtonsWidget.isEnabled, isFalse);
    });
  });
}
