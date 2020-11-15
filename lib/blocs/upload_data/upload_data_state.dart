import 'package:equatable/equatable.dart';
import 'package:tracer/models/data.dart';

abstract class UploadDataState extends Equatable {
  const UploadDataState();

  @override
  List<Object> get props => [];
}

class DataUploadInProgress extends UploadDataState {}

class DataUploadedSuccess extends UploadDataState {
  final int total;

  const DataUploadedSuccess([this.total = 0]);
  
  @override
  List<Object> get props => [total];

  @override
  String toString() => 'DataUploadedSuccess { data: $total }';

}

class DataUploadedFailure extends UploadDataState {}

