import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fav_coffee/features/coffee/data/exceptions/exceptions.dart';

class CoffeeRemoteDataSource {
  CoffeeRemoteDataSource({required Dio dio}) : _dio = dio;

  final Dio _dio;

  static const String _baseUrl = 'https://coffee.alexflipnote.dev';

  String get _randomImagePath => '$_baseUrl/random.json';

  Future<String> getRandomImageUrl() async {
    final response = await _dio.get<Map<String, dynamic>>(
      _randomImagePath,
    );

    final file = response.data?['file'] as String?;

    if (response.statusCode == 200 && file != null) {
      return file;
    }

    throw UnableToGetRandomImageException();
  }

  Future<Uint8List> getImageBytes(String imageUrl) async {
    final response = await _dio.get<List<int>>(
      imageUrl,
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );

    if (response.statusCode == 200 && response.data != null) {
      return Uint8List.fromList(response.data!);
    }

    throw UnableToGetRandomImageException();
  }
}
