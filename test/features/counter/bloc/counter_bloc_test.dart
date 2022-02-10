import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_driven_development/features/counter/bloc/counter_bloc.dart';
import 'package:test_driven_development/features/counter/models/counter_model.dart';
import 'package:test_driven_development/repository/repository.dart';

import '../../../helpers/hydrated_bloc.dart';

class MockRepository extends Mock implements Repository {}

void main() {
  late Repository repository;

  setUp(() {
    repository = MockRepository();
  });

  test("initial state is CounterLoading", () {
    expect(CounterBloc(repository: repository).state, CounterLoading());
  });

  group("toJson/fromJson ", () {
    test("work properly", () {
      mockHydratedStorage(() {
        final counterBloc = CounterBloc(repository: repository);

        expect(
          counterBloc.fromJson(counterBloc.toJson(counterBloc.state)),
          null,
        );
      });
    });
  });

  blocTest<CounterBloc, CounterState>(
    "emits [CounterLoading, CounterLoaded] when counter is loaded successfully",
    setUp: () {
      when(repository.loadCounter).thenAnswer((_) => 0);
    },
    build: () => mockHydratedStorage(() => CounterBloc(repository: repository)),
    act: (bloc) => bloc.add(CounterStarted()),
    expect: () =>
        <CounterState>[CounterLoading(), const CounterLoaded(CounterModel(0))],
    verify: (_) => verify(repository.loadCounter).called(1),
  );

  blocTest<CounterBloc, CounterState>(
    "emits [CounterLoading, CounterLoadingError] when counter is not loaded",
    setUp: () {
      when(repository.loadCounter).thenThrow(Exception("Error"));
    },
    build: () => CounterBloc(repository: repository),
    act: (bloc) => bloc.add(CounterStarted()),
    expect: () => <CounterState>[CounterLoading(), CounterLoadingError()],
    verify: (_) {
      verify(() => repository.loadCounter()).called(1);
    },
  );

  blocTest<CounterBloc, CounterState>(
    "emits [] when counter is not loaded and counter is added",
    setUp: () {
      when(repository.loadCounter).thenAnswer((_) => 0);
    },
    build: () => CounterBloc(repository: repository),
    act: (bloc) => bloc.add(CounterAdded()),
    expect: () => <CounterState>[],
  );

  blocTest<CounterBloc, CounterState>(
    "emits [CounterLoaded] when counter is added",
    setUp: () async {
      when(repository.loadCounter).thenAnswer((_) => 0);
    },
    build: () => mockHydratedStorage(() => CounterBloc(repository: repository)),
    seed: () => const CounterLoaded(CounterModel(0)),
    act: (bloc) => bloc.add(CounterAdded()),
    expect: () => <CounterState>[const CounterLoaded(CounterModel(1))],
  );

  blocTest<CounterBloc, CounterState>(
    "emits [CounterLoadingError] when counter is not added successfully",
    setUp: () {
      when(repository.addToCounter).thenThrow(Exception("Error"));
    },
    build: () => mockHydratedStorage(() => CounterBloc(repository: repository)),
    seed: () => const CounterLoaded(CounterModel(0)),
    act: (bloc) => bloc.add(CounterAdded()),
    expect: () => <CounterState>[CounterLoadingError()],
    verify: (_) {
      verify(() => repository.addToCounter()).called(1);
    },
  );
}
