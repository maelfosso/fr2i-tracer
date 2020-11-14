import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracer/blocs/data/data_bloc.dart';
import 'package:tracer/init.dart';
import 'package:tracer/screens/screens.dart';

void main() {
  runApp(TracerApp());
}

class TracerApp extends StatelessWidget {
  final Future _init =  Init.initialize();
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _init,
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.done){
          return MaterialApp(
            title: 'Tracer',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.blue,
              // This makes the visual density adapt to the platform that you run
              // the app on. For desktop platforms, the controls will be smaller and
              // closer together (more dense) than on mobile platforms.
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: BlocProvider(
              lazy: false,
              create: (BuildContext context) => DataBloc(),
              child: HomeScreen()
            )
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
