import 'package:flutter_test/flutter_test.dart';

import 'package:skillswap/main.dart';

void main() {
  testWidgets('SkillSwap app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SkillSwapApp());

    // Verify that the app starts with the login screen
    expect(find.text('SkillSwap'), findsOneWidget);
    expect(find.text('Exchange skills, grow together'), findsOneWidget);
  });
} 