import 'package:flutter_test/flutter_test.dart';
import 'package:test_driven_development/features/counter/bloc/counter_bloc.dart';

void main() {
  group("CounterEvent", () {
    group("CounterStarted", () {
      test("supports value comparison", () {
        expect(CounterStarted(), CounterStarted());
      });
    });

    group("CounterAdded", () {
      test("supports value comparison", () {
        expect(CounterAdded(), CounterAdded());
      });
    });
  });
}
