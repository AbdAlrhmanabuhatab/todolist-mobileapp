import 'package:flutter_test/flutter_test.dart';
import 'package:todolist/core/constants/app_strings.dart';
import 'package:todolist/core/widgets/app_primary_button.dart';
import 'package:todolist/main.dart';

void main() {
  testWidgets('App renders splash screen initially', (WidgetTester tester) async {
    await tester.pumpWidget(const TodoApp());
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.splashTitle), findsOneWidget);
    expect(find.text(AppStrings.getStarted), findsOneWidget);
  });

  testWidgets('Tapping Get Started navigates to LoginScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const TodoApp());
    await tester.pumpAndSettle();

    // Tap the Get Started button
    await tester.tap(find.widgetWithText(AppPrimaryButton, AppStrings.getStarted));
    await tester.pumpAndSettle();

    // Verify Login Screen is displayed
    expect(find.text('${AppStrings.welcomeBack}!'), findsOneWidget);
    expect(find.text(AppStrings.email), findsOneWidget);
    expect(find.text(AppStrings.password), findsOneWidget);
  });
}
