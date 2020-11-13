import 'package:equatable/equatable.dart';
import 'package:tracer/models/models.dart';

abstract class FilteredDataState extends Equatable {
  const FilteredDataState();

  @override
  List<Object> get props => [];
}

class FilteredDataLoadInProgress extends FilteredDataState {}

class FilteredDataLoadSuccess extends FilteredDataState {
  final List<Data> filteredData;
  final VisibilityFilter activeFilter;

  const FilteredDataLoadSuccess(
    this.filteredData,
    this.activeFilter,
  );

  @override
  List<Object> get props => [filteredData, activeFilter];

  @override
  String toString() {
    return 'FilteredDataLoadSuccess { filteredData: $filteredData, activeFilter: $activeFilter }';
  }
}
