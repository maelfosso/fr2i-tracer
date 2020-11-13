import 'package:equatable/equatable.dart';
import 'package:tracer/models/models.dart';

abstract class FilteredDataEvent extends Equatable {
  const FilteredDataEvent();
}

class FilterUpdated extends FilteredDataEvent {
  final VisibilityFilter filter;

  const FilterUpdated(this.filter);

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'FilterUpdated { filter: $filter }';
}

class DataUpdated extends FilteredDataEvent {
  final List<Data> data;

  const DataUpdated(this.data);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'DataUpdated { data: $data }';
}
