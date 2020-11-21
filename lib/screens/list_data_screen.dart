import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracer/blocs/data/data.dart';
import 'package:tracer/blocs/upload_data/upload_data.dart';
import 'package:tracer/screens/details_screen.dart';
import 'package:tracer/screens/keys.dart';
import 'package:tracer/widgets/data_item.dart';
import 'package:tracer/widgets/loading_indicator.dart';
import 'package:tracer/widgets/upload_data_dialog.dart';

class ListDataScreen extends StatelessWidget {
  DataBloc dataBloc;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Data"),
        actions: [
          IconButton(
            icon: Icon(Icons.sync),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => BlocProvider(
                  create: (_) => UploadDataBloc(dataBloc: dataBloc)..add(DataUpload()),
                  child: UploadDataDialog()
                )
              ); 
            },
          )
        ],
      ),
      body: BlocBuilder<DataBloc, DataState>(
        builder: (context, state) {
          print('\nLIST DATA STTATE -- $state');

          dataBloc = context.bloc<DataBloc>(); // 
          // dataBloc = BlocProvider.of<DataBloc>(context);
          dataBloc.add(DataLoad());
          print(dataBloc.state);
    
          if (state is DataLoadInProgress) {
            return LoadingIndicator();
          } else if (state is DataLoadSuccess) {

            final data = state.data;

            return ListView.builder(
              key: ArchSampleKeys.dataList,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final datum = data[index];
                print('\nBEFORE DATAITEM $datum');
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
                        return DetailsScreen(id: datum.id);
                      }),
                    );
                    
                    if (removedData != null) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        key: ArchSampleKeys.snackbar,
                        content: Text(
                          "Delete Data",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        duration: Duration(seconds: 2),
                        action: SnackBarAction(
                          label: "Undo",
                          onPressed: () => BlocProvider.of<DataBloc>(context)
                            .add(DataAdded(datum)),
                        ),
                      ));
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
      ),
      floatingActionButton: FloatingActionButton(
        key: ArchSampleKeys.addDataScreen,
        onPressed: () {
          Navigator.pushNamed(context, ArchSampleRoutes.addData);
        },
        child: Icon(Icons.add),
        tooltip: "Add new data"
      )
    );
  }
}
