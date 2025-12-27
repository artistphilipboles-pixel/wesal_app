import 'package:flutter_test/flutter_test.dart';

import 'package:wesal_app/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const WesalApp());

    // Verify that the Splash Screen appears with the app title.
    expect(find.text('Wesal'), findsOneWidget);
  });
}
