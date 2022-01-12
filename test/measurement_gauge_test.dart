import 'package:farm_data_exercise/widgets/measurement_gauge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MeasurementGauge(
            value: 5,
            text: 'text',
          ),
        ),
      ),
    );

    final text = find.text('text');
    final valueText = find.text('5.0');
    expect(valueText, findsOneWidget);
    expect(text, findsOneWidget);
  });
}
