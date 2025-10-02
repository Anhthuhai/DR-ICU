// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:dr_icu/main.dart';

void main() {
  testWidgets('DR ICU app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const DrIcuApp());

    // Verify that our app title appears.
    expect(find.text('DR ICU'), findsOneWidget);
    
    // Verify welcome text appears.
    expect(find.text('Chào mừng đến với DR ICU'), findsOneWidget);
    
    // Verify that clinical scores feature card appears.
    expect(find.text('Thang điểm lâm sàng'), findsOneWidget);
  });
}
