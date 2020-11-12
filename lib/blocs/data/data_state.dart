import 'package:equatable/equatable.dart';
import 'package:tracer/models/data.dart';

abstract class DataState extends Equatable {
  const DataState();

  @override
  List<Object> get props => [];
}

class DataLoadInProgress extends DataState {}

class DataLoadSuccess extends DataState {
  final List<Data> data;

  const DataLoadSuccess([this.data = const []]);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'DataLoadSuccess { data: $data }';
}

class DataLoadFailure extends DataState {}
