import 'package:get_it/get_it.dart';
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
  }

  static Future _initSembast() async {
    final appDir = await getApplicationDocumentsDirectory();
    await appDir.create(recursive: true);
    final databasePath = join(appDir.path, "sembast.db");
    final database = await databaseFactoryIo.openDatabase(databasePath);
    GetIt.I.registerSingleton<Database>(database);
    print("_initSembast is OK");
  }

  static _registerRepositories(){
    print("starting registering repositories");
    GetIt.I.registerLazySingleton<DataRepository>(() => LocalDataRepository()); 
    print("finished registering repositories");
  }
}
