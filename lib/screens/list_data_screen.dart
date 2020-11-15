import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracer/blocs/data/data_bloc.dart';
import 'package:tracer/blocs/data/data_event.dart';
import 'package:tracer/blocs/data/data_state.dart';
import 'package:tracer/models/models.dart';
import 'package:tracer/screens/add_edit_data_screen.dart';
import 'package:tracer/screens/keys.dart';
import 'package:tracer/widgets/data_item.dart';
import 'package:tracer/widgets/loading_indicator.dart';

class ListDataScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Data"),
      ),
      body: BlocBuilder<DataBloc, DataState>(
        builder: (context, state) {
          print("List DATA SCREEN ... $state");

          if (state is DataLoadInProgress) {
            return LoadingIndicator();
          } else if (state is DataLoadSuccess) {
            final data = state.data;

            return ListView.builder(
              key: ArchSampleKeys.dataList,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final datum = data[index];

                return DataItem(
                  data: datum,
                  onDismissed: (direction) {
                    BlocProvider.of<DataBloc>(context).add(DataDeleted(datum));
                    Scaffold.of(context).showSnackBar(SnackBar(
                      duration: Duration(seconds: 3),
                      content: Text(
                        "Data ${datum.id} deleted",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis
                      ),
                      action: SnackBarAction(
                        label: "Undo",
                        onPressed: () {},
                      ),
                    ));
                  },
                  onTap: () async {
                    final removedData = await Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) {
                        return AddEditDataScreen(
                          isEditing: true,
                          data: datum,
                          onSave: (name, sex, age, longitude, latitude, altitude, id) {
                            BlocProvider.of<DataBloc>(context).add(
                              DataUpdated(
                                Data(name, sex, 0, longitude, latitude, altitude, id)
                              ) 
                            );
                          },
                        );
                      })
                    );

                    if (removedData != null) {
                      
                    }
                  },
                );
              }
            );
          } else {
            return Center(
              child: Text("Empty..... Not now"),
            );
          }
        },
      )
    );
  }
}
