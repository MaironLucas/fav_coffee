import 'package:fav_coffee/features/coffee/data/data.dart';
import 'package:fav_coffee/features/coffee/domain/domain.dart';

class CoffeeRepository {
  CoffeeRepository({
    required CoffeeRemoteDataSource remoteDataSource,
    required CoffeeLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  final CoffeeRemoteDataSource _remoteDataSource;
  final CoffeeLocalDataSource _localDataSource;

  String _getImageIdFromUrl(String imageUrl) {
    return imageUrl.split('/').last.split('.').first;
  }

  Future<CoffeeImage> getRandomImage() async {
    final imageUrl = await _remoteDataSource.getRandomImageUrl();
    final imageId = _getImageIdFromUrl(imageUrl);

    final localImage = await _localDataSource.getImage(imageId);

    if (localImage != null) {
      return localImage.toDomain();
    }

    final imageBytes = await _remoteDataSource.getImageBytes(imageUrl);

    final coffeeImage = CoffeeImage(
      id: imageId,
      bytes: imageBytes,
    );

    return coffeeImage;
  }

  Future<void> favoriteImage(CoffeeImage image) async {
    final localImage = image.toLocal();

    await _localDataSource.saveImage(localImage);
  }

  Future<List<CoffeeImage>> getAllFavoriteImages() async {
    final localImages = await _localDataSource.getAllImages();

    return localImages
        .map(
          (localImage) => localImage.toDomain(),
        )
        .toList();
  }
}
