
import 'package:equatable/equatable.dart';

class CounterModel extends Equatable {
  final int counter;

  const CounterModel(this.counter);

  @override
  List<Object?> get props => [counter];

  Map<String, dynamic> toMap() {
    return {
      'counter': counter,
    };
  }

  factory CounterModel.fromMap(Map<String, dynamic> map) {
    return CounterModel(
      map['counter']?.toInt() ?? 0,
    );
  }
}
