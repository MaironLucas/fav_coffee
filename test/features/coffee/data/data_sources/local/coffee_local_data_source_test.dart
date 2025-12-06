import 'dart:io' as io;
import 'dart:typed_data';

import 'package:fav_coffee/features/coffee/data/data_sources/local/local.dart';
import 'package:file/memory.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final fakeImageBytes = Uint8List.fromList([0, 1, 2, 3, 4, 5]);

  late CoffeeLocalDataSource dataSource;
  late MemoryFileSystem memoryFileSystem;

  setUp(() async {
    memoryFileSystem = MemoryFileSystem();

    const mockPath = '/test/documents';

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

  test('getImage should return null if file does not exist', () async {
    final result = await dataSource.getImage('non_existent');

    expect(result, null);
  });

  test('getAllImages should return list of saved images', () async {
    final dir = memoryFileSystem.directory('/test/documents');
    await dir.create(recursive: true);

    await memoryFileSystem.file('${dir.path}/pic1.png').writeAsBytes([10]);
    await memoryFileSystem.file('${dir.path}/pic2.png').writeAsBytes([20]);
    await memoryFileSystem.file('${dir.path}/not_image.txt').writeAsBytes([30]);

    final result = await dataSource.getAllImages();

    expect(result.length, 2);
    expect(result.any((img) => img.id == 'pic1'), true);
  });
}
