import 'package:fav_coffee/features/coffee/domain/models/models.dart';
import 'package:fav_coffee/features/coffee/presentation/presentation.dart';
import 'package:fav_coffee/features/shared/shared.dart';
import 'package:fav_coffee/l10n/gen/app_localizations_en.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/helpers.dart';

class MockFavoriteCoffeeCubit extends Mock implements FavoriteCoffeeCubit {}

void main() {
  group('FavoriteCoffeePage', () {
    final fakeCoffeeImages = [
      CoffeeImage(
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
      ),
      CoffeeImage(
        id: '2',
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
      ),
    ];
    late FavoriteCoffeeCubit favoriteCoffeeCubit;

    setUp(() {
      favoriteCoffeeCubit = MockFavoriteCoffeeCubit();

      when(favoriteCoffeeCubit.close).thenAnswer((_) async {});

      registerFakeDependencies(
        favoriteCoffeeCubit: favoriteCoffeeCubit,
      );
    });

    tearDown(removeInstances);

    void mockState(FavoriteCoffeeState state) {
      when(() => favoriteCoffeeCubit.stream).thenAnswer(
        (_) => Stream.value(state),
      );
      when(() => favoriteCoffeeCubit.state).thenAnswer(
        (_) => state,
      );
    }

    testWidgets('initializes FavoriteCoffeeCubit and calls initialize', (
      WidgetTester tester,
    ) async {
      mockState(LoadingFavoriteCoffeeState());

      await tester.pumpAppPage(const FavoriteCoffeePage());

      verify(favoriteCoffeeCubit.initialize).called(1);
    });

    testWidgets('displays loading indicator when state is loading', (
      WidgetTester tester,
    ) async {
      mockState(LoadingFavoriteCoffeeState());

      await tester.pumpAppPage(const FavoriteCoffeePage());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays empty message when favorite list is empty', (
      WidgetTester tester,
    ) async {
      mockState(SuccessFavoriteCoffeeState(favoriteImages: []));

      await tester.pumpAppPage(const FavoriteCoffeePage());

      expect(
        find.text(AppLocalizationsEn().favoriteCoffeePageEmptyText),
        findsWidgets,
      );
    });

    testWidgets('displays grid of favorite images when state is success', (
      WidgetTester tester,
    ) async {
      mockState(SuccessFavoriteCoffeeState(favoriteImages: fakeCoffeeImages));

      await tester.pumpAppPage(const FavoriteCoffeePage());

      expect(find.byType(GridView), findsOneWidget);
      expect(find.byType(FavoriteCoffeeImageCardWidget), findsWidgets);
    });

    testWidgets('displays error widget when state is error', (
      WidgetTester tester,
    ) async {
      mockState(ErrorFavoriteCoffeeState());

      await tester.pumpAppPage(const FavoriteCoffeePage());

      expect(find.byType(ErrorIndicatorWidget), findsOneWidget);
    });

    testWidgets('calls getFavoriteCoffees when retry button is tapped', (
      WidgetTester tester,
    ) async {
      mockState(ErrorFavoriteCoffeeState());
      when(() => favoriteCoffeeCubit.getFavoriteCoffees()).thenAnswer(
        (_) async {},
      );

      await tester.pumpAppPage(const FavoriteCoffeePage());

      final retryButtonFinder = find.text(
        AppLocalizationsEn().tryAgainButtonText,
      );
      await tester.tap(retryButtonFinder);

      verify(
        () => favoriteCoffeeCubit.getFavoriteCoffees(),
      ).called(1);
    });

    testWidgets('navigates to details page when image is tapped', (
      WidgetTester tester,
    ) async {
      mockState(SuccessFavoriteCoffeeState(favoriteImages: fakeCoffeeImages));

      await tester.pumpAppPage(const FavoriteCoffeePage());

      final imageCardFinder = find.byType(FavoriteCoffeeImageCardWidget).first;
      await tester.tap(imageCardFinder);
      await tester.pumpAndSettle();

      expect(find.byType(FavoriteCoffeeDetailsPage), findsOneWidget);
    });
  });
}
