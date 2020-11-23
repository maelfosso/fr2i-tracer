import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracer/blocs/classified_picture/classified_picture.dart';
import 'package:tracer/blocs/data/data_bloc.dart';
import 'package:tracer/blocs/data/data_event.dart';
import 'package:tracer/blocs/simple_bloc_observer.dart';
import 'package:tracer/init.dart';
import 'package:tracer/models/models.dart';
import 'package:tracer/screens/add_edit_data_screen.dart';
import 'package:tracer/screens/classify_picture_screen.dart';
import 'package:tracer/screens/keys.dart';
import 'package:tracer/screens/list_data_screen.dart';
import 'package:tracer/screens/screens.dart';
import 'package:tracer/screens/take_picture_screen.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(BlocProvider(
    create: (BuildContext context) => DataBloc()..add(DataLoad()),
    // lazy: false,
    child: TracerApp(),
  ));
}

class TracerApp extends StatefulWidget {
  @override
  _TracerStateApp createState() => _TracerStateApp();
}

class _TracerStateApp extends State<TracerApp> {
  final Future _init =  Init.initialize();
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _init,
      builder: (context, snapshot){
        print('\nFUTUREBUILDDER ... $snapshot');

        if (snapshot.connectionState == ConnectionState.done){
          return MaterialApp(
            title: 'Tracer',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: HomeScreen(),
            routes: {
              ArchSampleRoutes.listData: (context) {
                return ListDataScreen();
              },
              ArchSampleRoutes.addData: (context) {
                return AddEditDataScreen(
                    key: ArchSampleKeys.addDataScreen,
                    isEditing: false,
                    onSave: (name, sex, age, longitude, latitude, altitude, id) {
                      BlocProvider.of<DataBloc>(context).add(
                        DataAdded(
                          Data(name, sex, 0, longitude, latitude, altitude, 0, state: VisibilityFilter.notsynchronized.index.toInt())
                        ) 
                      );
                    },
                  );
              },
              ArchSampleRoutes.takePicture: (context) {
                return TakePictureScreen();
              },
              ArchSampleRoutes.classifyPicture: (context) {
                return BlocProvider(
                  create: (BuildContext context) => ClassifiedPictureBloc(),
                  child: ClassifyPictureScreen()
                );
              },
            },
          );
        } else {
          return Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
