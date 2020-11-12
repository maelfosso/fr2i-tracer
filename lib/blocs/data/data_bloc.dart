import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tracer/blocs/data/data.dart';
import 'package:tracer/models/data.dart';
import 'package:tracer/data_repository/data_repository.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final DataRepository dataRepository;

  DataBloc({@required this.dataRepository}) : super(DataLoadInProgress());

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is DataLoad) {
      yield* _mapDataLoadedToState();
    } else if (event is DataAdded) {
      yield* _mapDataAddedToState(event);
    } else if (event is DataUpdated) {
      yield* _mapDataUpdatedToState(event);
    } else if (event is DataDeleted) {
      yield* _mapDataDeletedToState(event);
    } else if (event is ToggleAll) {
      yield* _mapToggleAllToState();
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    }
  }

  Stream<DataState> _mapDataLoadedToState() async* {
    try {
      final data = await this.dataRepository.loadData();
      yield DataLoad(
        data.map(Data.fromEntity).toList(),
      );
    } catch (_) {
      yield DataLoadFailure();
    }
  }

  Stream<DataState> _mapDataAddedToState(DataAdded event) async* {
    if (state is DataLoad) {
      final List<Data> updatedData = List.from((state as DataLoad).data)
        ..add(event.todo);
      yield DataLoad(updatedData);
      _saveData(updatedData);
    }
  }

  Stream<DataState> _mapDataUpdatedToState(DataUpdated event) async* {
    if (state is DataLoad) {
      final List<Data> updatedData = (state as DataLoad).data.map((todo) {
        return todo.id == event.updatedData.id ? event.updatedData : todo;
      }).toList();
      yield DataLoad(updatedData);
      _saveData(updatedData);
    }
  }

  Stream<DataState> _mapDataDeletedToState(DataDeleted event) async* {
    if (state is DataLoad) {
      final updatedData = (state as DataLoad)
          .data
          .where((todo) => todo.id != event.todo.id)
          .toList();
      yield DataLoad(updatedData);
      _saveData(updatedData);
    }
  }

  Stream<DataState> _mapToggleAllToState() async* {
    if (state is DataLoad) {
      final allComplete =
          (state as DataLoad).data.every((todo) => todo.complete);
      final List<Data> updatedData = (state as DataLoad)
          .data
          .map((todo) => todo.copyWith(complete: !allComplete))
          .toList();
      yield DataLoad(updatedData);
      _saveData(updatedData);
    }
  }

  Stream<DataState> _mapClearCompletedToState() async* {
    if (state is DataLoad) {
      final List<Data> updatedData =
          (state as DataLoad).data.where((todo) => !todo.complete).toList();
      yield DataLoad(updatedData);
      _saveData(updatedData);
    }
  }

  Future _saveData(List<Data> data) {
    return dataRepository.saveData(
      data.map((todo) => todo.toEntity()).toList(),
    );
  }
}