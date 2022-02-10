import 'package:flutter_test/flutter_test.dart';
import 'package:test_driven_development/features/counter/bloc/counter_bloc.dart';
import 'package:test_driven_development/features/counter/models/counter_model.dart';

class FakeCounterModel extends Fake implements CounterModel {}

void main() {
  group("CounterState", () {
    group("CounterLoading", () {
      test("supports value comparison", () {
        expect(CounterLoading(), CounterLoading());
      });
    });

    group("CounterLoaded", () {
      final counterModel = FakeCounterModel();
      test("supports value comparison", () {
        expect(CounterLoaded(counterModel), CounterLoaded(counterModel));
      });
    });
  });

  group("CounterLoadingError", () {
      test("supports value comparison", () {
        expect(CounterLoadingError(), CounterLoadingError());
      });
    });
}
