import 'dart:io';

import 'package:camera/camera.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:tracer/data_repository/data_repository.dart';
import 'package:tracer/data_repository/local_data_repository.dart';

class Init {
  static Future initialize() async {
    print('\nInit initialize....\n');

    await _initSembast();
    _registerRepositories();
    await _enabledLocationService();
    await _camera();
  }

  static Future _initSembast() async {
    final appDir = await getApplicationDocumentsDirectory();
    await appDir.create(recursive: true);
    final databasePath = join(appDir.path, "db/sembast.db");
    final database = await databaseFactoryIo.openDatabase(databasePath);
    GetIt.I.registerSingleton<Database>(database);
    print("_initSembast is OK");
  }

  static _registerRepositories(){
    print("starting registering repositories");
    GetIt.I.registerLazySingleton<DataRepository>(() => LocalDataRepository()); 
    print("finished registering repositories");
  }

  static _enabledLocationService() async {
    Location location = Location();

    bool _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    PermissionStatus _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

  }

  static _camera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    GetIt.I.registerSingleton<CameraDescription>(firstCamera);

    final directory = Directory(join((await getApplicationDocumentsDirectory()).path, 'pictures'));
    if (!(await directory.exists())) {
      await directory.create();
    }
  }
}
