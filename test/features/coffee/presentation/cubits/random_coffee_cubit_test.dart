import 'package:bloc_test/bloc_test.dart';
import 'package:fav_coffee/features/coffee/domain/domain.dart';
import 'package:fav_coffee/features/coffee/presentation/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCoffeeRepository extends Mock implements CoffeeRepository {}

void main() {
  group('RandomCoffeeCubit', () {
    final fakeCoffeeImage = CoffeeImage(
      id: 'image1',
      bytes: Uint8List.fromList([1, 2, 3, 4]),
    );

    late CoffeeRepository coffeeRepository;
    late RandomCoffeeCubit randomCoffeeCubit;

    setUp(() {
      coffeeRepository = MockCoffeeRepository();
      randomCoffeeCubit = RandomCoffeeCubit(coffeeRepository: coffeeRepository);
    });

    test('initial state is LoadingRandomCoffeeState', () {
      expect(randomCoffeeCubit.state, isA<LoadingRandomCoffeeState>());
    });

    group('getRandomImage', () {
      blocTest<RandomCoffeeCubit, RandomCoffeeState>(
        'emits [LoadingRandomCoffeeState, SuccessRandomCoffeeState] when'
        ' getRandomImage succeeds',
        build: () => randomCoffeeCubit,
        setUp: () {
          when(() => coffeeRepository.getRandomImage()).thenAnswer(
            (_) async => fakeCoffeeImage,
          );
        },
        act: (bloc) => bloc.getRandomImage(),
        expect: () => [
          LoadingRandomCoffeeState(),
          SuccessRandomCoffeeState(coffeeImage: fakeCoffeeImage),
        ],
        verify: (bloc) => verify(
          () => coffeeRepository.getRandomImage(),
        ).called(1),
      );

      blocTest<RandomCoffeeCubit, RandomCoffeeState>(
        'emits [LoadingRandomCoffeeState, ErrorRandomCoffeeState] when'
        ' getRandomImage fails',
        build: () => randomCoffeeCubit,
        setUp: () {
          when(
            () => coffeeRepository.getRandomImage(),
          ).thenThrow(Exception());
        },
        act: (bloc) => bloc.getRandomImage(),
        expect: () => [
          LoadingRandomCoffeeState(),
          ErrorRandomCoffeeState(),
        ],
        verify: (bloc) => verify(
          () => coffeeRepository.getRandomImage(),
        ).called(1),
      );
    });

    group('favoriteImage', () {
      blocTest<RandomCoffeeCubit, RandomCoffeeState>(
        'emits [LoadingRandomCoffeeState, SuccessRandomCoffeeState] when'
        ' favoriteImage succeeds',
        build: () => randomCoffeeCubit,
        seed: () => SuccessRandomCoffeeState(coffeeImage: fakeCoffeeImage),
        setUp: () {
          when(
            () => coffeeRepository.favoriteImage(fakeCoffeeImage),
          ).thenAnswer((_) async {});
          when(() => coffeeRepository.getRandomImage()).thenAnswer(
            (_) async => fakeCoffeeImage,
          );
        },
        act: (bloc) => bloc.favoriteImage(),
        expect: () => [
          LoadingRandomCoffeeState(),
          SuccessRandomCoffeeState(coffeeImage: fakeCoffeeImage),
        ],
        verify: (bloc) {
          verify(
            () => coffeeRepository.favoriteImage(fakeCoffeeImage),
          ).called(1);
          verify(
            () => coffeeRepository.getRandomImage(),
          ).called(1);
        },
      );

      blocTest<RandomCoffeeCubit, RandomCoffeeState>(
        'emits [SavingImageFailureRandomCoffeeState, SuccessRandomCoffeeState]'
        ' when favoriteImage fails',
        build: () => randomCoffeeCubit,
        seed: () => SuccessRandomCoffeeState(coffeeImage: fakeCoffeeImage),
        setUp: () {
          when(
            () => coffeeRepository.favoriteImage(fakeCoffeeImage),
          ).thenThrow(Exception());
        },
        act: (bloc) => bloc.favoriteImage(),
        expect: () => [
          SavingImageFailureRandomCoffeeState(
            coffeeImage: fakeCoffeeImage,
          ),
          SuccessRandomCoffeeState(coffeeImage: fakeCoffeeImage),
        ],
        verify: (bloc) {
          verify(
            () => coffeeRepository.favoriteImage(fakeCoffeeImage),
          ).called(1);
        },
      );

      blocTest(
        'emits nothing when current state is not SuccessRandomCoffeeState',
        build: () => randomCoffeeCubit,
        act: (bloc) => bloc.favoriteImage(),
        expect: () => <void>[],
      );
    });
  });
}
