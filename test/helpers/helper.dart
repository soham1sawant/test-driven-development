import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_driven_development/features/counter/bloc/counter_bloc.dart';

class MockCounterBloc extends MockBloc<CounterEvent, CounterState>
    implements CounterBloc {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp({
    CounterBloc? counterBloc,
    required Widget child,
  }) {
    return pumpWidget(MaterialApp(
      home: MultiBlocProvider(
        providers: [
          counterBloc != null
              ? BlocProvider.value(value: counterBloc)
              : BlocProvider(create: (_) => MockCounterBloc()),
        ],
        child: child,
      ),
    ));
  }
}
