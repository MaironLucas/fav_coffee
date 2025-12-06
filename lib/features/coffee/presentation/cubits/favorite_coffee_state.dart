import 'package:equatable/equatable.dart';
import 'package:fav_coffee/features/coffee/domain/domain.dart';

sealed class FavoriteCoffeeState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class LoadingFavoriteCoffeeState extends FavoriteCoffeeState {}

class SuccessFavoriteCoffeeState extends FavoriteCoffeeState {
  SuccessFavoriteCoffeeState({required this.favoriteImages});

  final List<CoffeeImage> favoriteImages;

  @override
  List<Object?> get props => [favoriteImages];
}

class ErrorFavoriteCoffeeState extends FavoriteCoffeeState {}
