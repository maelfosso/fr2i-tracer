import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:bloc/bloc.dart';
import 'package:tracer/blocs/data/data.dart';
import 'package:tracer/models/models.dart';
import 'package:tracer/data_repository/data_repository.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final DataRepository dataRepository = GetIt.I.get<DataRepository>();

  DataBloc() : super(DataLoadInProgress()); 

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
      // print('\nLOADING DATA');
      final data = await this.dataRepository.getAllData();
      // print('\nLOADEEEDDD DATA $data');
      yield DataLoadSuccess(data);
    } catch (_) {
      yield DataLoadFailure();
    }
  }

  Stream<DataState> _mapDataAddedToState(DataAdded event) async* {
    if (state is DataLoadSuccess) {
      final result = await this.dataRepository.insertData(event.data);
      final List<Data> updatedData = List.from((state as DataLoadSuccess).data)
        ..add(event.data.copyWith(id: result));

      yield DataLoadSuccess(updatedData);
    }
  }

  Stream<DataState> _mapDataUpdatedToState(DataUpdated event) async* {
    print('\n_mapDataUpdatedToState .... ${event.data} --- $state');
    if (state is DataLoadSuccess) {
      print('\nInto mapDataUpdatedToState');
      final List<Data> updatedData = (state as DataLoadSuccess).data.map((data) {
        return data.id == event.data.id ? event.data : data;
      }).toList();
      print('\nLOCAL UPDATE $updatedData');
      
      this.dataRepository.updateData(event.data);
      yield DataLoadSuccess(updatedData);
    }
    print('\nEnd of mapDataUpdatedToState');
  }

  Stream<DataState> _mapDataDeletedToState(DataDeleted event) async* {
    if (state is DataLoadSuccess) {
      final updatedData = (state as DataLoadSuccess)
          .data
          .where((data) => data.id != event.data.id)
          .toList();
      this.dataRepository.deleteData(event.data.id);
      yield DataLoadSuccess(updatedData);
    }
  }

  Stream<DataState> _mapToggleAllToState() async* {

  }

  Stream<DataState> _mapClearCompletedToState() async* {
  }

}