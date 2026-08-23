import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:inxee_hr_application/main.dart';

void main() {
  testWidgets('App loads modern login page', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: InxeeHRApp(),
      ),
    );

    expect(find.text('Employee Login'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });
}
