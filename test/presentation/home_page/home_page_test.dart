import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_driven_development/features/counter/bloc/counter_bloc.dart';
import 'package:test_driven_development/features/counter/models/counter_model.dart';
import 'package:test_driven_development/presentation/home_page/home_page.dart';

import '../../helpers/helper.dart';

void main() {
  late CounterBloc counterBloc;

  setUp(() {
    counterBloc = MockCounterBloc();
  });

  group("HomePage", () {
    testWidgets(
      "renders CircularProgress Indicator when counter is loading",
      (tester) async {
        when(() => counterBloc.state).thenReturn(CounterLoading());
        await tester.pumpApp(
          child: const HomePage(title: "Counter App"),
          counterBloc: counterBloc,
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      "renders counter when counter is loaded",
      (tester) async {
        when(() => counterBloc.state)
            .thenReturn(const CounterLoaded(CounterModel(0)));
        await tester.pumpApp(
          child: const HomePage(title: "Counter App"),
          counterBloc: counterBloc,
        );

        expect(find.text("0"), findsOneWidget);
      },
    );

    testWidgets(
      "renders Error Icon when counter fails to load",
      (tester) async {
        when(() => counterBloc.state).thenReturn(CounterLoadingError());
        await tester.pumpApp(
          child: const HomePage(title: "Counter App"),
          counterBloc: counterBloc,
        );

        expect(find.byIcon(Icons.error), findsOneWidget);
      },
    );
  });
}
