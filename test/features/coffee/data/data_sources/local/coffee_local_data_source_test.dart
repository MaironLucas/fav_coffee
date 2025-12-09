import 'dart:io' as io;
import 'dart:typed_data';

import 'package:fav_coffee/features/coffee/data/data_sources/local/local.dart';
import 'package:file/memory.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final fakeImageBytes = Uint8List.fromList([0, 1, 2, 3, 4, 5]);
  const mockPath = '/test/documents';

  late CoffeeLocalDataSource dataSource;
  late MemoryFileSystem memoryFileSystem;

  setUp(() async {
    memoryFileSystem = MemoryFileSystem();

    await memoryFileSystem.directory(mockPath).create(recursive: true);

    Future<io.Directory> mockGetDirectory() async {
      return io.Directory(mockPath);
    }

    dataSource = CoffeeLocalDataSource(
      getDirectory: mockGetDirectory,
      fileSystem: memoryFileSystem,
    );
  });

  test('saveImage should write bytes to the memory file system', () async {
    final image = CoffeeImageLocal(id: '123', bytes: fakeImageBytes);

    await dataSource.saveImage(image);

    final file = memoryFileSystem.file('/test/documents/123.png');

    expect(file.existsSync(), true);
    expect(await file.readAsBytes(), fakeImageBytes);
  });

  group('getImage', () {
    test('should return null if file does not exist', () async {
      final result = await dataSource.getImage('non_existent');

      expect(result, null);
    });

    test('should return CoffeeImageLocal if file exists', () async {
      await memoryFileSystem.file('$mockPath/pic1.png').writeAsBytes([10]);

      final result = await dataSource.getImage('pic1');

      expect(result, isA<CoffeeImageLocal>());
    });
  });

  test('getAllImages should return list of saved images', () async {
    await memoryFileSystem.file('$mockPath/pic1.png').writeAsBytes([10]);
    await memoryFileSystem.file('$mockPath/pic2.png').writeAsBytes([20]);
    await memoryFileSystem.file('$mockPath/not_image.txt').writeAsBytes([30]);

    final result = await dataSource.getAllImages();

    expect(result.length, 2);
    expect(result.any((img) => img.id == 'pic1'), true);
  });
}
