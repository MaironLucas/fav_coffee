import 'package:fav_coffee/features/shared/presentation/widgets/error_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/helpers.dart';

void main() {
  group('ErrorIndicatorWidget', () {
    testWidgets('displays error message', (WidgetTester tester) async {
      const testMessage = 'Test error message';
      await tester.pumpAppWidget(
        ErrorIndicatorWidget(
          message: testMessage,
          onRetry: () {},
        ),
      );

      expect(find.text(testMessage), findsOneWidget);
    });

    testWidgets('calls onRetry callback when button is pressed', (
      WidgetTester tester,
    ) async {
      var retryPressed = false;
      await tester.pumpAppWidget(
        Scaffold(
          body: ErrorIndicatorWidget(
            message: 'Error',
            onRetry: () => retryPressed = true,
          ),
        ),
      );

      await tester.tap(find.byType(TextButton));
      expect(retryPressed, isTrue);
    });
  });
}
