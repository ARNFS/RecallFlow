
import 'package:flutter_test/flutter_test.dart';
import 'package:recallflow/main.dart';

void main() {
  testWidgets('RecallFlow home screen loads', (WidgetTester tester) async {
    await tester.pumpWidget(const RecallFlowApp());

    expect(find.text('RecallFlow'), findsOneWidget);
    expect(find.text('YOUR LEARNING SPACE'), findsOneWidget);
    expect(find.text("TODAY'S STUDY GOAL"), findsOneWidget);
    expect(find.text('Learning overview'), findsOneWidget);
  });
}
