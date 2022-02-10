import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../repository/repository.dart';
import '../models/counter_model.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends HydratedBloc<CounterEvent, CounterState> {
  final Repository repository;

  CounterBloc({required this.repository}) : super(CounterLoading()) {
    on<CounterStarted>(_onStarted);
    on<CounterAdded>(_onCounterAdded);
    on<CounterMadeZero>(_onCounterMadeZero);
  }

  void _onStarted(CounterStarted event, Emitter<CounterState> emit) async {
    emit(CounterLoading());

    try {
      final counterValue = repository.loadCounter();
      emit(CounterLoaded(CounterModel(counterValue)));
    } catch (_) {
      emit(CounterLoadingError());
    }
  }

  void _onCounterAdded(CounterAdded event, Emitter<CounterState> emit) async {
    final state = this.state;

    if (state is CounterLoaded) {
      try {
        repository.addToCounter();
        emit(CounterLoaded(CounterModel(state.counterModel.counter + 1)));
      } catch (_) {
        emit(CounterLoadingError());
      }
    }
  }

  void _onCounterMadeZero(
      CounterMadeZero event, Emitter<CounterState> emit) async {
    final state = this.state;

    if (state is CounterLoaded) {
      try {
        repository.makeCounterZero();
        emit(const CounterLoaded(CounterModel(0)));
      } catch (_) {
        emit(CounterLoadingError());
      }
    }
  }

  @override
  CounterState? fromJson(Map<String, dynamic>? json) {
    try {
      final data = CounterLoaded.fromMap(json!);
      repository.counter = data.counterModel.counter;

      return CounterLoaded(data.counterModel);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(CounterState state) {
    if (state is CounterLoaded) {
      return state.toMap();
    } else {
      return null;
    }
  }
}
