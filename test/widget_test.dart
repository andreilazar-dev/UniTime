// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_timetable/app.dart';

class MockStorage extends Mock implements Storage {}

void main() {
  late Storage storage;

  setUp(() {
    storage = MockStorage();
    when(
          () => storage.write(any(), any<dynamic>()),
    ).thenAnswer((_) async {});
    HydratedBloc.storage = storage;
  });

  testWidgets('Pump app widget', (WidgetTester tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();

    await tester.pumpWidget(App());
  });
}
