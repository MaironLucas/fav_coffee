import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fav_coffee/features/coffee/data/data.dart';
import 'package:fav_coffee/features/coffee/data/exceptions/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group('CoffeeRemoteDataSource', () {
    late MockDio mockDio;
    late CoffeeRemoteDataSource dataSource;

    setUp(() {
      mockDio = MockDio();
      dataSource = CoffeeRemoteDataSource(dio: mockDio);
    });

    group('getRandomImageUrl', () {
      test('returns image URL when the response is successful', () async {
        const imageUrl = 'https://coffee.alexflipnote.dev/123456.jpg';
        final fakeResponse = Response<Map<String, dynamic>>(
          data: {'file': imageUrl},
          statusCode: 200,
          requestOptions: RequestOptions(),
        );

        when(
          () => mockDio.get<Map<String, dynamic>>(
            any(),
          ),
        ).thenAnswer(
          (_) async => fakeResponse,
        );

        final result = await dataSource.getRandomImageUrl();

        expect(result, equals(imageUrl));

        verify(
          () => mockDio.get<Map<String, dynamic>>(
            'https://coffee.alexflipnote.dev/random.json',
          ),
        ).called(1);
      });

      test('throws UnableToGetRandomImageException when statusCode'
          ' is different from 200', () async {
        final fakeResponse = Response<Map<String, dynamic>>(
          data: {},
          statusCode: 400,
          requestOptions: RequestOptions(),
        );

        when(
          () => mockDio.get<Map<String, dynamic>>(
            any(),
          ),
        ).thenAnswer(
          (_) async => fakeResponse,
        );

        await expectLater(
          () => dataSource.getRandomImageUrl(),
          throwsA(isA<UnableToGetRandomImageException>()),
        );

        verify(
          () => mockDio.get<Map<String, dynamic>>(
            'https://coffee.alexflipnote.dev/random.json',
          ),
        ).called(1);
      });

      test(
        'throws UnableToGetRandomImageException when file is null',
        () async {
          final fakeResponse = Response<Map<String, dynamic>>(
            data: {},
            statusCode: 200,
            requestOptions: RequestOptions(),
          );

          when(
            () => mockDio.get<Map<String, dynamic>>(
              any(),
            ),
          ).thenAnswer(
            (_) async => fakeResponse,
          );

          await expectLater(
            () => dataSource.getRandomImageUrl(),
            throwsA(isA<UnableToGetRandomImageException>()),
          );

          verify(
            () => mockDio.get<Map<String, dynamic>>(
              'https://coffee.alexflipnote.dev/random.json',
            ),
          ).called(1);
        },
      );
    });

    group('getImageBytes', () {
      test('returns image bytes when the response is successful', () async {
        const imageUrl = 'https://coffee.alexflipnote.dev/123456.jpg';
        final imageBytes = [137, 80, 78, 71];
        final fakeResponse = Response<List<int>>(
          data: imageBytes,
          statusCode: 200,
          requestOptions: RequestOptions(),
        );

        when(
          () => mockDio.get<List<int>>(
            imageUrl,
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) async => fakeResponse,
        );

        final result = await dataSource.getImageBytes(imageUrl);

        expect(result, equals(Uint8List.fromList(imageBytes)));

        verify(
          () => mockDio.get<List<int>>(
            imageUrl,
            options: any(named: 'options'),
          ),
        ).called(1);
      });

      test(
        'throws UnableToGetRandomImageException when statusCode is different'
        ' from 200',
        () async {
          const imageUrl = 'https://coffee.alexflipnote.dev/123456.jpg';
          final fakeResponse = Response<List<int>>(
            data: [],
            statusCode: 400,
            requestOptions: RequestOptions(),
          );

          when(
            () => mockDio.get<List<int>>(
              imageUrl,
              options: any(named: 'options'),
            ),
          ).thenAnswer(
            (_) async => fakeResponse,
          );

          await expectLater(
            () => dataSource.getImageBytes(imageUrl),
            throwsA(isA<UnableToGetRandomImageException>()),
          );
        },
      );

      test(
        'throws UnableToGetRandomImageException when data is null',
        () async {
          const imageUrl = 'https://coffee.alexflipnote.dev/123456.jpg';
          final fakeResponse = Response<List<int>>(
            statusCode: 200,
            requestOptions: RequestOptions(),
          );

          when(
            () => mockDio.get<List<int>>(
              imageUrl,
              options: any(named: 'options'),
            ),
          ).thenAnswer(
            (_) async => fakeResponse,
          );

          await expectLater(
            () => dataSource.getImageBytes(imageUrl),
            throwsA(isA<UnableToGetRandomImageException>()),
          );
        },
      );
    });
  });
}
