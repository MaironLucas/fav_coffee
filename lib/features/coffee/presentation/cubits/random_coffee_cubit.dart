import 'package:bloc/bloc.dart';
import 'package:fav_coffee/features/coffee/domain/domain.dart';
import 'package:fav_coffee/features/coffee/presentation/cubits/random_coffee_state.dart';

class RandomCoffeeCubit extends Cubit<RandomCoffeeState> {
  RandomCoffeeCubit({required CoffeeRepository coffeeRepository})
    : _coffeeRepository = coffeeRepository,
      super(LoadingRandomCoffeeState());

  final CoffeeRepository _coffeeRepository;

  void initialize() => getRandomImage();

  Future<void> getRandomImage() async {
    emit(LoadingRandomCoffeeState());

    try {
      final coffeeImage = await _coffeeRepository.getRandomImage();

      emit(SuccessRandomCoffeeState(coffeeImage: coffeeImage));
    } on Exception catch (_) {
      emit(ErrorRandomCoffeeState());
    }
  }

  Future<void> favoriteImage() async {
    final currentState = state;

    if (currentState is SuccessRandomCoffeeState) {
      try {
        await _coffeeRepository.favoriteImage(currentState.coffeeImage);

        await getRandomImage();
      } on Exception catch (_) {
        emit(
          SavingImageFailureRandomCoffeeState(
            coffeeImage: currentState.coffeeImage,
          ),
        );
        emit(currentState);
        return;
      }
    }
  }
}
