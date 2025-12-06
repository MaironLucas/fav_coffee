import 'dart:typed_data';

import 'package:fav_coffee/features/coffee/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CoffeeImage', () {
    test('two instances with save values are equal and have same hashCode', () {
      final image1 = CoffeeImage(
        id: 'test_id',
        bytes: Uint8List.fromList([0, 1, 2, 3, 4, 5]),
      );
      final image2 = CoffeeImage(
        id: 'test_id',
        bytes: Uint8List.fromList([0, 1, 2, 3, 4, 5]),
      );

      expect(image1, equals(image2));
      expect(image1.hashCode, equals(image2.hashCode));
    });

    test(
      'two instances with different values are not equal and not have '
      'same hashCode',
      () {
        final image1 = CoffeeImage(
          id: 'test_id',
          bytes: Uint8List.fromList([0, 1, 2, 3, 4, 5, 6]),
        );
        final image2 = CoffeeImage(
          id: 'test_id',
          bytes: Uint8List.fromList([0, 1, 2, 3, 4, 5]),
        );

        expect(image1, isNot(equals(image2)));
        expect(image1.hashCode, isNot(equals(image2.hashCode)));
      },
    );
  });
}
