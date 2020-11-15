import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';
import 'package:tracer/models/models.dart';
import 'package:tracer/data_repository/data_repository.dart';

class LocalDataRepository extends DataRepository {
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store("data_store");

  @override
  Future<int> insertData(Data data) async {
    return await _store.add(_database, data.toMap());
  }

  @override
  Future updateData(Data data) async {
    await _store.record(data.id).update(_database, data.toMap());
  }

  @override
  Future deleteData(int dataId) async {
    await _store.record(dataId).delete(_database);
  }

  @override
  Future<List<Data>> getAllData() async {
    final snapshots = await _store.find(_database);
    return snapshots
        .map((snapshot) => Data.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }
}