import 'dart:typed_data';

import 'package:fav_coffee/features/shared/presentation/widgets/memory_image_widget.dart';
import 'package:fav_coffee/l10n/gen/app_localizations_en.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/helpers.dart';

void main() {
  group('MemoryImageWidget', () {
    late Uint8List validImageBytes;

    setUpAll(() {
      validImageBytes = Uint8List.fromList([
        137,
        80,
        78,
        71,
        13,
        10,
        26,
        10,
        0,
        0,
        0,
        13,
        73,
        72,
        68,
        82,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        1,
        8,
        6,
        0,
        0,
        0,
        31,
        21,
        196,
        137,
        0,
        0,
        0,
        10,
        73,
        68,
        65,
        84,
        8,
        153,
        99,
        0,
        1,
        0,
        0,
        5,
        0,
        1,
        13,
        10,
        45,
        180,
        0,
        0,
        0,
        0,
        73,
        69,
        78,
        68,
        174,
        66,
        96,
        130,
      ]);
    });

    testWidgets('renders Image.memory with valid bytes', (
      WidgetTester tester,
    ) async {
      await tester.pumpAppWidget(
        MemoryImageWidget(validImageBytes),
      );

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('renders with custom width', (WidgetTester tester) async {
      const width = 100.0;

      await tester.pumpAppWidget(
        MemoryImageWidget(validImageBytes, width: width),
      );

      final image = find.byType(Image);
      expect(image, findsOneWidget);
    });

    testWidgets('displays error text when image fails to load', (
      WidgetTester tester,
    ) async {
      final invalidImageBytes = Uint8List.fromList([0, 0, 0, 0]);

      await tester.pumpAppWidget(
        MemoryImageWidget(invalidImageBytes),
      );

      await tester.pumpAndSettle();

      expect(find.byType(Center), findsOneWidget);
      expect(
        find.text(AppLocalizationsEn().memoryImageErrorText),
        findsOneWidget,
      );
    });
  });
}
