import 'package:flutter_test/flutter_test.dart';
import 'package:test_driven_development/features/counter/models/counter_model.dart';

void main() {
  group("CounterModel", () {
    test("supports value comparison", () {
      expect(const CounterModel(0), const CounterModel(0));
    });
  });
}
