import 'dart:typed_data';

import 'package:fav_coffee/features/coffee/data/data.dart';
import 'package:fav_coffee/features/coffee/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCoffeeLocalDataSource extends Mock implements CoffeeLocalDataSource {}

class MockCoffeeRemoteDataSource extends Mock
    implements CoffeeRemoteDataSource {}

void main() {
  group('CoffeeRepository', () {
    late MockCoffeeLocalDataSource mockLocalDataSource;
    late MockCoffeeRemoteDataSource mockRemoteDataSource;
    late CoffeeRepository coffeeRepository;

    setUp(() {
      mockLocalDataSource = MockCoffeeLocalDataSource();
      mockRemoteDataSource = MockCoffeeRemoteDataSource();
      coffeeRepository = CoffeeRepository(
        localDataSource: mockLocalDataSource,
        remoteDataSource: mockRemoteDataSource,
      );
    });

    setUpAll(() {
      registerFallbackValue(
        CoffeeImageLocal(
          id: 'fallback',
          bytes: Uint8List.fromList([]),
        ),
      );
    });

    group('getRandomImage', () {
      test('returns CoffeeImage from local data source if available', () async {
        const imageUrl = 'https://example.com/images/coffee123.jpg';
        const imageId = 'coffee123';
        final localImage = CoffeeImageLocal(
          id: imageId,
          bytes: Uint8List.fromList([0, 1, 2, 3, 4]),
        );
        final image = CoffeeImage(
          id: imageId,
          bytes: Uint8List.fromList([0, 1, 2, 3, 4]),
        );

        when(
          () => mockRemoteDataSource.getRandomImageUrl(),
        ).thenAnswer((_) async => imageUrl);
        when(
          () => mockLocalDataSource.getImage(any()),
        ).thenAnswer((_) async => localImage);

        final result = await coffeeRepository.getRandomImage();

        expect(result, equals(image));
        verify(() => mockRemoteDataSource.getRandomImageUrl()).called(1);
        verify(() => mockLocalDataSource.getImage(imageId)).called(1);
        verifyNever(() => mockRemoteDataSource.getImageBytes(imageUrl));
      });

      test('returns CoffeeImage from remote data source', () async {
        const imageUrl = 'https://example.com/images/coffee123.jpg';
        const imageId = 'coffee123';
        final image = CoffeeImage(
          id: imageId,
          bytes: Uint8List.fromList([0, 1, 2, 3, 4]),
        );

        when(
          () => mockRemoteDataSource.getRandomImageUrl(),
        ).thenAnswer((_) async => imageUrl);
        when(
          () => mockLocalDataSource.getImage(any()),
        ).thenAnswer((_) async => null);
        when(
          () => mockRemoteDataSource.getImageBytes(any()),
        ).thenAnswer((_) async => Uint8List.fromList([0, 1, 2, 3, 4]));

        final result = await coffeeRepository.getRandomImage();

        expect(result, equals(image));
        verify(() => mockRemoteDataSource.getRandomImageUrl()).called(1);
        verify(() => mockLocalDataSource.getImage(imageId)).called(1);
        verify(() => mockRemoteDataSource.getImageBytes(imageUrl)).called(1);
      });
    });

    group('favoriteImage', () {
      test('saves CoffeeImage to local data source', () async {
        const imageId = 'coffee123';
        final image = CoffeeImage(
          id: imageId,
          bytes: Uint8List.fromList([0, 1, 2, 3, 4]),
        );
        final localImage = CoffeeImageLocal(
          id: imageId,
          bytes: Uint8List.fromList([0, 1, 2, 3, 4]),
        );

        when(
          () => mockLocalDataSource.saveImage(any()),
        ).thenAnswer((_) async {});

        await expectLater(
          coffeeRepository.favoriteImage(image),
          completes,
        );

        verify(() => mockLocalDataSource.saveImage(localImage)).called(1);
      });
    });

    group('getAllFavoriteImages', () {
      test('returns list of CoffeeImage from local data source', () async {
        final localImages = [
          CoffeeImageLocal(
            id: 'coffee1',
            bytes: Uint8List.fromList([0, 1, 2]),
          ),
          CoffeeImageLocal(
            id: 'coffee2',
            bytes: Uint8List.fromList([3, 4, 5]),
          ),
        ];
        final images = [
          CoffeeImage(
            id: 'coffee1',
            bytes: Uint8List.fromList([0, 1, 2]),
          ),
          CoffeeImage(
            id: 'coffee2',
            bytes: Uint8List.fromList([3, 4, 5]),
          ),
        ];

        when(
          () => mockLocalDataSource.getAllImages(),
        ).thenAnswer((_) async => localImages);

        final result = await coffeeRepository.getAllFavoriteImages();

        expect(result, equals(images));
        verify(() => mockLocalDataSource.getAllImages()).called(1);
      });
    });
  });
}
