part of 'counter_bloc.dart';

abstract class CounterState extends Equatable {
  const CounterState();

  @override
  List<Object> get props => [];
}

class CounterLoading extends CounterState {
  @override
  List<Object> get props => [];
}

class CounterLoaded extends CounterState {
  final CounterModel counterModel;

  const CounterLoaded(this.counterModel);

  @override
  List<Object> get props => [counterModel];


  Map<String, dynamic> toMap() {
    return {
      'counterModel': counterModel.toMap(),
    };
  }

  factory CounterLoaded.fromMap(Map<String, dynamic> map) {
    return CounterLoaded(
      CounterModel.fromMap(map['counterModel']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CounterLoaded.fromJson(String source) => CounterLoaded.fromMap(json.decode(source));
}

class CounterLoadingError extends CounterState {
  @override
  List<Object> get props => [];
}
