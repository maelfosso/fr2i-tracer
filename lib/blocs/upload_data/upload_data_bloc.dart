import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:tracer/blocs/data/data.dart';
import 'package:tracer/blocs/upload_data/upload_data.dart';
import 'package:tracer/data_repository/data_entity.dart';
import 'package:tracer/data_repository/data_repository.dart';
import 'package:tracer/models/models.dart';

class UploadDataBloc extends Bloc<UploadDataEvent, UploadDataState> {
  final DataRepository dataRepository = GetIt.I.get<DataRepository>();
  final DataBloc dataBloc;

  UploadDataBloc({@required this.dataBloc})
      : super(DataUploadInProgress());

  @override
  Stream<UploadDataState> mapEventToState(UploadDataEvent event) async* {
    if (event is DataUpload) {
      yield* _mapDataUploadToState(event);
    }
  }

  Stream<UploadDataState> _mapDataUploadToState(UploadDataEvent event) async* {
    print('\nINTO _mapDataUploadTostate.... ');
    
    print('\nLET GO _mapDataUploadTostate.... ');
    final data = (this.dataBloc.state as DataLoadSuccess)
        .data
        .where((data) => data.state == VisibilityFilter.notsynchronized)
        .toList();
    print('\nSize of data to upload ... ${data.length}');

    yield* _uploadData(data);
    print('\nEVERYTHING IS OK');
    
    print('\nEND OF _mapDataUploadTostate.... ');
  }

  Stream<UploadDataState> _uploadData(List<Data> stream) async* {
    final total = stream.length;
    print('\nUpload DATA : $total');

    yield DataUploadStarted(total);

    for (final value in stream) {
      try {
        final entity = await postData(value);
        print('\nDATA UPLOADED SUCCESSFULLY $entity');
        yield DataUploadedSuccess(entity);

        // this.dataRepository.updateData(entity.toData());
        this.dataBloc.add(DataUpdated(entity.toData()));
        // print('\nDATA LOCALLY UPDATED SUCCESSFULLY ${entity.toData()}');

      } catch (e) {
        print('\nERROR occurred with $value');
        print(e);
        yield DataUploadedFailure();
      }
    }

    // yield DataUploadEnded();
  }

  Future<DataEntity> postData(Data data) async {
    final http.Response response = await http.post(
      'http://192.168.8.100:4000/api/data',
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(data.toMap())
    );
    if (response.statusCode == 201) {
      print(response.body);
      return DataEntity.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to upload $data. \nResponse Status Code ${response.statusCode}');
    }
  }

}
