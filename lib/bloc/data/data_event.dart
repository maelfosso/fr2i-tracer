import 'package:equatable/equatable.dart';
import 'package:tracer/models/data.dart';

abstract class DataEvent extends Equatable {
  const DataEvent();

  @override
  List<Object> get props => [];
}

class DataLoadSuccess extends DataEvent {}

class DataAdded extends DataEvent {
  final Data data;

  const DataAdded(this.data);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'DataAdded { data: $data }';
}

class DataUpdated extends DataEvent {
  final Data data;

  const DataUpdated(this.data);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'DataUpdated { data: $data }';
}

class DataDeleted extends DataEvent {
  final Data data;

  const DataDeleted(this.data);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'DataDeleted { data: $data }';
}

class ClearCompleted extends DataEvent {}

class ToggleAll extends DataEvent {}
