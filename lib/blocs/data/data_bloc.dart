import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:bloc/bloc.dart';
import 'package:tracer/blocs/data/data.dart';
import 'package:tracer/blocs/upload_data/upload_data.dart';
import 'package:tracer/blocs/upload_data/upload_data_bloc.dart';
import 'package:tracer/data_repository/data_entity.dart';
import 'package:tracer/models/models.dart';
import 'package:tracer/data_repository/data_repository.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final DataRepository dataRepository = GetIt.I.get<DataRepository>();
  
  // UploadDataBloc uploadDataBloc;
  // StreamSubscription uploadDataSubscription;

  DataBloc() : super(DataLoadInProgress()); 
  // {
  //   uploadDataSubscription = uploadDataBloc.listen((state) {
  //     if (state is DataUploadedSuccess) {
  //       add(DataUpdated(state.data.toData()));
  //     }
  //   });
  // }

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    print('\n+++++ \tmapEventToState ... $event \n');
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
      final data = await this.dataRepository.getAllData();
      yield DataLoadSuccess(data);
    } catch (_) {
      yield DataLoadFailure();
    }
  }

  Stream<DataState> _mapDataAddedToState(DataAdded event) async* {
    print('\nInto _mapDataAddedToState - ${event.data} - $state');
    if (state is DataLoadSuccess) {
      final result = await this.dataRepository.insertData(event.data);
      final List<Data> updatedData = List.from((state as DataLoadSuccess).data)
        ..add(event.data.copyWith(id: result));
      print("Result $result \tAdded Data ${event.data}");
      yield DataLoadSuccess(updatedData);
    }
    print('\nEnd of _mapDataAddedToState');
  }

  Stream<DataState> _mapDataUpdatedToState(DataUpdated event) async* {
    if (state is DataLoadSuccess) {
      final List<Data> updatedData = (state as DataLoadSuccess).data.map((data) {
        return data.id == event.data.id ? event.data : data;
      }).toList();
      this.dataRepository.updateData(event.data);
      yield DataLoadSuccess(updatedData);
    }
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