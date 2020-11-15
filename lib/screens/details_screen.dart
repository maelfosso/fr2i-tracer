import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracer/blocs/data/data.dart';
import 'package:tracer/screens/add_edit_data_screen.dart';
import 'package:tracer/screens/keys.dart';

class DetailsScreen extends StatelessWidget {
  final int id;

  DetailsScreen({Key key, @required this.id})
      : super(key: key ?? ArchSampleKeys.dataDetailsScreen);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, DataState>(
      builder: (context, state) {
        
        final data = (state as DataLoadSuccess)
            .data
            .firstWhere((datum) => datum.id == id, orElse: () => null);
            
        return Scaffold(
          appBar: AppBar(
            title: Text("Details"),
            actions: [
              IconButton(
                tooltip: "Delete",
                key: ArchSampleKeys.deleteDataButton,
                icon: Icon(Icons.delete),
                onPressed: () {
                  BlocProvider.of<DataBloc>(context).add(DataDeleted(data));
                  Navigator.pop(context, data);
                },
              )
            ],
          ),
          body: data == null
              ? Container(child: Center(child: Text("NOTHING")))
              : Container(
                  child: ListView(
                    children: [
                      ListTile(
                        title: Text("Name"),
                        subtitle: Text(data.name),
                        dense: true,
                      ),
                      ListTile(
                        title: Text("Sex"),
                        subtitle: Text(data.sex),
                        dense: true,
                      ),
                      ListTile(
                        title: Text("Age"),
                        subtitle: Text(data.age.toString()),
                        dense: true,
                      ),
                      ListTile(
                        title: Text("Longitude"),
                        subtitle: Text(data.longitude),
                        dense: true,
                      ),
                      ListTile(
                        title: Text("Latitude"),
                        subtitle: Text(data.latitude),
                        dense: true,
                      ),
                      ListTile(
                        title: Text("Altitude"),
                        subtitle: Text(data.altitude),
                        dense: true,
                      )
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            key: ArchSampleKeys.editDataFab,
            tooltip: "Edit",
            child: Icon(Icons.edit),
            onPressed: data == null
                ? null
                : () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return AddEditDataScreen(
                            key: ArchSampleKeys.editDataScreen,
                            onSave: (name, sex, age, longitude, latitude, altitude, id) {
                              BlocProvider.of<DataBloc>(context).add(
                                DataUpdated(
                                  data.copyWith(
                                    name: name, 
                                    sex: sex, 
                                    age: age, 
                                    longitude: longitude, 
                                    latitude: latitude, 
                                    altitude: altitude, 
                                    id: id
                                  ),
                                ),
                              );
                            },
                            isEditing: true,
                            data: data,
                          );
                        },
                      ),
                    );
                  },
          ),
        );
      },
    );
  }
}
