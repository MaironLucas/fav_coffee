import 'package:fav_coffee/features/coffee/presentation/presentation.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockRandomCoffeeCubit extends Mock implements RandomCoffeeCubit {}

class MockFavoriteCoffeeCubit extends Mock implements FavoriteCoffeeCubit {}

void registerFakeDependencies({
  RandomCoffeeCubit? randomCoffeeCubit,
  FavoriteCoffeeCubit? favoriteCoffeeCubit,
}) => GetIt.instance
  ..registerFactory<RandomCoffeeCubit>(
    () => randomCoffeeCubit ?? MockRandomCoffeeCubit(),
  )
  ..registerFactory<FavoriteCoffeeCubit>(
    () => favoriteCoffeeCubit ?? MockFavoriteCoffeeCubit(),
  );

void removeInstances() => GetIt.instance.reset();
