import 'dart:async';
import 'dart:core';

import 'package:tracer/data_repository/data_entity.dart';
import 'package:tracer/models/models.dart';

abstract class DataRepository {

  Future<int> insertData(Data data);

  Future updateData(Data data);

  Future deleteData(int dataId);

  Future<List<Data>> getAllData();
}