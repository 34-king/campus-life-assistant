import 'package:flutter_test/flutter_test.dart';
import 'package:xyshzsapp/main.dart';

void main() {
  testWidgets('App renders with bottom navigation', (WidgetTester tester) async {
    await tester.pumpWidget(const CampusLifeApp());

    // Verify bottom navigation destinations exist
    expect(find.text('首页'), findsOneWidget);
    expect(find.text('课程'), findsOneWidget);
    expect(find.text('食堂'), findsOneWidget);
    expect(find.text('公告'), findsOneWidget);
    expect(find.text('我的'), findsOneWidget);
  });
}
