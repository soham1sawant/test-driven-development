part of 'counter_bloc.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

class CounterStarted extends CounterEvent{

  @override
  List<Object> get props => [];
}

class CounterAdded extends CounterEvent{
  
  @override
  List<Object> get props => [];
}

class CounterMadeZero extends CounterEvent{
  
  @override
  List<Object> get props => [];
}