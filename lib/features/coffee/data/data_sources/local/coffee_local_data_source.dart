import 'dart:io' as io;

import 'package:fav_coffee/features/coffee/data/data_sources/local/local.dart';
import 'package:file/file.dart';

class CoffeeLocalDataSource {
  CoffeeLocalDataSource({
    required Future<io.Directory> Function() getDirectory,
    required FileSystem fileSystem,
  }) : _getDirectory = getDirectory,
       _fileSystem = fileSystem;

  final Future<io.Directory> Function() _getDirectory;
  final FileSystem _fileSystem;

  Future<String> _getImagePath(String imageId) async {
    final directoryPath = (await _getDirectory()).path;
    return '$directoryPath/$imageId.png';
  }

  Future<void> saveImage(CoffeeImageLocal image) async {
    final filePath = await _getImagePath(image.id);
    final file = await _fileSystem.file(filePath).create();
    await file.writeAsBytes(image.bytes);
  }

  Future<CoffeeImageLocal?> getImage(String id) async {
    final filePath = await _getImagePath(id);
    final file = _fileSystem.file(filePath);

    if (file.existsSync()) {
      final bytes = await file.readAsBytes();
      return CoffeeImageLocal(id: id, bytes: bytes);
    }

    return null;
  }

  Future<List<CoffeeImageLocal>> getAllImages() async {
    final directory = await _getDirectory();
    final fsDirectory = _fileSystem.directory(directory.path);
    final files = fsDirectory.listSync();

    final images = <CoffeeImageLocal>[];

    for (final fileEntity in files) {
      if (fileEntity is File && fileEntity.path.endsWith('.png')) {
        final id = fileEntity.uri.pathSegments.last.split('.').first;
        final bytes = await fileEntity.readAsBytes();
        images.add(CoffeeImageLocal(id: id, bytes: bytes));
      }
    }

    return images;
  }
}
