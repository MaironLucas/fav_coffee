import 'package:equatable/equatable.dart';
import 'package:fav_coffee/features/coffee/domain/domain.dart';

sealed class RandomCoffeeState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class LoadingRandomCoffeeState extends RandomCoffeeState {}

class SuccessRandomCoffeeState extends RandomCoffeeState {
  SuccessRandomCoffeeState({
    required this.coffeeImage,
  });

  final CoffeeImage coffeeImage;

  @override
  List<Object?> get props => [coffeeImage];
}

class SavingImageFailureRandomCoffeeState extends SuccessRandomCoffeeState {
  SavingImageFailureRandomCoffeeState({
    required super.coffeeImage,
  });
}

class ErrorRandomCoffeeState extends RandomCoffeeState {}
