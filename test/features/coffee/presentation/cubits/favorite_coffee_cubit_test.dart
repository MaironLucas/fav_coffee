import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:fav_coffee/features/coffee/domain/domain.dart';
import 'package:fav_coffee/features/coffee/presentation/presentation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCoffeeRepository extends Mock implements CoffeeRepository {}

void main() {
  group('FavoriteCoffeeCubit', () {
    final fakeCoffeeImages = [
      CoffeeImage(id: 'image1', bytes: Uint8List.fromList([1, 2, 3])),
      CoffeeImage(id: 'image2', bytes: Uint8List.fromList([4, 5, 6])),
    ];

    late CoffeeRepository coffeeRepository;
    late FavoriteCoffeeCubit favoriteCoffeeCubit;

    setUp(() {
      coffeeRepository = MockCoffeeRepository();
      favoriteCoffeeCubit = FavoriteCoffeeCubit(
        coffeeRepository: coffeeRepository,
      );
    });

    test('initial state is LoadingFavoriteCoffeeState', () {
      expect(favoriteCoffeeCubit.state, isA<LoadingFavoriteCoffeeState>());
    });

    group('getFavoriteCoffees', () {
      blocTest<FavoriteCoffeeCubit, FavoriteCoffeeState>(
        'emits [LoadingFavoriteCoffeeState, SuccessFavoriteCoffeeState] when'
        ' getFavoriteCoffees succeeds',
        build: () => favoriteCoffeeCubit,
        setUp: () {
          when(() => coffeeRepository.getAllFavoriteImages()).thenAnswer(
            (_) async => fakeCoffeeImages,
          );
        },
        act: (cubit) => cubit.getFavoriteCoffees(),
        expect: () => [
          LoadingFavoriteCoffeeState(),
          SuccessFavoriteCoffeeState(favoriteImages: fakeCoffeeImages),
        ],
        verify: (cubit) => verify(
          () => coffeeRepository.getAllFavoriteImages(),
        ).called(1),
      );

      blocTest<FavoriteCoffeeCubit, FavoriteCoffeeState>(
        'emits [LoadingFavoriteCoffeeState, ErrorFavoriteCoffeeState] when'
        ' getFavoriteCoffees fails',
        build: () => favoriteCoffeeCubit,
        setUp: () {
          when(
            () => coffeeRepository.getAllFavoriteImages(),
          ).thenThrow(Exception());
        },
        act: (cubit) => cubit.getFavoriteCoffees(),
        expect: () => [
          LoadingFavoriteCoffeeState(),
          ErrorFavoriteCoffeeState(),
        ],
        verify: (cubit) => verify(
          () => coffeeRepository.getAllFavoriteImages(),
        ).called(1),
      );
    });

    group('initialize', () {
      blocTest<FavoriteCoffeeCubit, FavoriteCoffeeState>(
        'calls getFavoriteCoffees when initialize is called',
        build: () => favoriteCoffeeCubit,
        setUp: () {
          when(() => coffeeRepository.getAllFavoriteImages()).thenAnswer(
            (_) async => fakeCoffeeImages,
          );
        },
        act: (cubit) => cubit.initialize(),
        expect: () => [
          LoadingFavoriteCoffeeState(),
          SuccessFavoriteCoffeeState(favoriteImages: fakeCoffeeImages),
        ],
        verify: (cubit) => verify(
          () => coffeeRepository.getAllFavoriteImages(),
        ).called(1),
      );
    });
  });
}
