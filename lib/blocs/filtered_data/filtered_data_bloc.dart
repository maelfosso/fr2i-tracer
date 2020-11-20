import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tracer/blocs/filtered_data/filtered_data.dart';
import 'package:tracer/blocs/data/data.dart';
import 'package:tracer/models/models.dart';

class FilteredDataBloc extends Bloc<FilteredDataEvent, FilteredDataState> {
  final DataBloc dataBloc;
  StreamSubscription dataSubscription;

  FilteredDataBloc({@required this.dataBloc})
      : super(
          dataBloc.state is DataLoadSuccess
              ? FilteredDataLoadSuccess(
                  (dataBloc.state as DataLoadSuccess).data,
                  VisibilityFilter.all,
                )
              : FilteredDataLoadInProgress(),
        ) {
    dataSubscription = dataBloc.listen((state) {
      if (state is DataLoadSuccess) {
        add(DataListUpdated((dataBloc.state as DataLoadSuccess).data));
      }
    });
  }

  @override
  Stream<FilteredDataState> mapEventToState(FilteredDataEvent event) async* {
    if (event is FilterUpdated) {
      yield* _mapUpdateFilterToState(event);
    } else if (event is DataListUpdated) {
      yield* _mapDataListUpdatedToState(event);
    }
  }

  Stream<FilteredDataState> _mapUpdateFilterToState(
    FilterUpdated event,
  ) async* {
    if (dataBloc.state is DataLoadSuccess) {
      yield FilteredDataLoadSuccess(
        _mapDataToFilteredData(
          (dataBloc.state as DataLoadSuccess).data,
          event.filter,
        ),
        event.filter,
      );
    }
  }

  Stream<FilteredDataState> _mapDataListUpdatedToState(
    DataListUpdated event,
  ) async* {
    final visibilityFilter = state is FilteredDataLoadSuccess
        ? (state as FilteredDataLoadSuccess).activeFilter
        : VisibilityFilter.all;
    yield FilteredDataLoadSuccess(
      _mapDataToFilteredData(
        (dataBloc.state as DataLoadSuccess).data,
        visibilityFilter,
      ),
      visibilityFilter,
    );
  }

  List<Data> _mapDataToFilteredData(
      List<Data> data, VisibilityFilter filter) {
    return data.where((data) {
      // if (filter == VisibilityFilter.all) {
      //   return true;
      // } else if (filter == VisibilityFilter.draft) {
      //   return data.status == "draft";
      // } else if (filter == VisibilityFilter.synchronized {
      //   return data.status == "synchronized";
      // } else if (filter == VisibilityFilter.notsynchronized {
      //   return data.status == "notsynchronized";
      // } else if (filter == VisibilityFilter.notsynchronized {
      //   return data.status == "saved";
      // }
      return true;
    }).toList();
  }

  @override
  Future<void> close() {
    dataSubscription.cancel();
    return super.close();
  }
}
