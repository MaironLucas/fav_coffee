import 'package:fav_coffee/features/coffee/domain/domain.dart';
import 'package:fav_coffee/features/coffee/presentation/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCoffeeCubit extends Cubit<FavoriteCoffeeState> {
  FavoriteCoffeeCubit({required this.coffeeRepository})
    : super(LoadingFavoriteCoffeeState());

  final CoffeeRepository coffeeRepository;

  void initialize() => getFavoriteCoffees();

  Future<void> getFavoriteCoffees() async {
    emit(LoadingFavoriteCoffeeState());

    try {
      final favoriteImages = await coffeeRepository.getAllFavoriteImages();

      emit(SuccessFavoriteCoffeeState(favoriteImages: favoriteImages));
    } on Exception catch (_) {
      emit(ErrorFavoriteCoffeeState());
    }
  }
}
