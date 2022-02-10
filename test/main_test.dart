import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_driven_development/features/counter/bloc/counter_bloc.dart';
import 'package:test_driven_development/main.dart';
import 'package:test_driven_development/presentation/home_page/home_page.dart';
import 'package:test_driven_development/repository/repository.dart';

class MockRepository extends Mock implements Repository {}

void main() {
  late Repository repository;

  setUp(() {
    repository = MockRepository();
  });
  testWidgets("renders HomePage (initial page)", (tester) async {
    await tester.pumpWidget(App(repository: repository));

    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets("checks for Scaffold", (tester) async {
    await tester.pumpWidget(App(repository: repository));

    expect(find.byType(Scaffold), findsOneWidget);
  });

  testWidgets("checks for MultiBlocProvider", (tester) async {
    await tester.pumpWidget(App(repository: repository));

    expect(find.byType(MultiBlocProvider), findsOneWidget);
  });

  testWidgets("checks for Text", (tester) async {
    await tester.pumpWidget(App(repository: repository));

    expect(find.text("You have pushed the button this many times :"),
        findsOneWidget);
  });

  testWidgets("checks for BlocBuilder", (tester) async {
    await tester.pumpWidget(App(repository: repository));

    expect(find.byType(BlocBuilder<CounterBloc, CounterState>), findsOneWidget);
  });

  testWidgets("checks for FloatingActionButton", (tester) async {
    await tester.pumpWidget(App(repository: repository));

    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
