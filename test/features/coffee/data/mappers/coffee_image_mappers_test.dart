import 'dart:typed_data';

import 'package:fav_coffee/features/coffee/data/data_sources/local/local.dart';
import 'package:fav_coffee/features/coffee/data/mappers/coffee_image_mappers.dart';
import 'package:fav_coffee/features/coffee/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CoffeeImageDomainMapper', () {
    test('toLocal maps CoffeeImage to CoffeeImageLocal', () {
      final coffeeImage = CoffeeImage(
        id: 'test_id',
        bytes: Uint8List.fromList([0, 1, 2, 3, 4, 5]),
      );

      final expectedCoffeeImageLocal = CoffeeImageLocal(
        id: 'test_id',
        bytes: Uint8List.fromList([0, 1, 2, 3, 4, 5]),
      );

      final coffeeImageLocal = coffeeImage.toLocal();

      expect(coffeeImageLocal, equals(expectedCoffeeImageLocal));
    });
  });

  group('CoffeeImageLocalMapper', () {
    test('toDomain maps CoffeeImageLocal to CoffeeImage', () {
      final coffeeImageLocal = CoffeeImageLocal(
        id: 'test_id',
        bytes: Uint8List.fromList([0, 1, 2, 3, 4, 5]),
      );

      final expectedCoffeeImage = CoffeeImage(
        id: 'test_id',
        bytes: Uint8List.fromList([0, 1, 2, 3, 4, 5]),
      );

      final coffeeImage = coffeeImageLocal.toDomain();

      expect(coffeeImage, equals(expectedCoffeeImage));
    });
  });
}
