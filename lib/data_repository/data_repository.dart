import 'dart:async';
import 'dart:core';

import 'package:meta/meta.dart';
import 'package:tracer/data_repository/data_entity.dart';

class DataRepository {

  @override
  Future<List<DataEntity>> loadData() async {
    try {
      return await localStorage.loadDatas();
    } catch (e) {
      final datas = await webClient.loadDatas();

      await localStorage.saveDatas(datas);

      return datas;
    }
  }

  // Persists datas to local disk and the web
  @override
  Future saveData(List<DataEntity> datas) {
    return Future.wait<dynamic>([
      localStorage.saveDatas(datas),
      webClient.saveDatas(datas),
    ]);
  }

  Future saveDatum(DataEntity data) {

  }
}