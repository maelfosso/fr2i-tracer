import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracer/blocs/data/data.dart';
import 'package:tracer/blocs/upload_data/upload_data.dart';
import 'package:tracer/widgets/loading_indicator.dart';

class UploadDataDialog extends StatefulWidget {
  @override
  _UploadDataStateDialog createState() => _UploadDataStateDialog();
}

class _UploadDataStateDialog extends State<UploadDataDialog> {
  int total = 0;
  int current = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Dialog(
      child: Container(
        height: 150,
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              margin: EdgeInsets.only(bottom: 16.0),
              child: Text(
                "Synchronize Data",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<UploadDataBloc, UploadDataState>(
                    builder: (context, state) {
                      if (state is DataUploadInProgress) {
                        return LoadingIndicator();
                      } else if (state is DataUploadStarted) {
                        total = state.total;
                        if (total == 0) {
                          return Center(
                            child: Text("Nothing to synchronize")
                          );
                        }
                      } else if (state is DataUploadedSuccess) {
                        current += 1;
                        BlocProvider.of<DataBloc>(context).add(DataUpdated(state.data.toData()));
                      } else if (state is DataUploadedFailure) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: new Text("Error"),
                              content: new Text("An error during the synchronization. Kindly be sure that you set up the good parameter"),
                            );
                          }
                        );
                        return Container();
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          LinearProgressIndicator(
                            value: current/total,
                          ),
                          Text(
                            "$current/$total",
                            textAlign: TextAlign.right,
                          ),
                          Visibility(
                            visible: current == total,
                            child: Text('Close the app and reopen it please'),
                          )
                        ],
                      );
                    }
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FlatButton(
                        child: Text("OK"),
                        onPressed: () {
                          BlocProvider.of<DataBloc>(context).add(DataLoad());
                          Navigator.pop(context);
                        },
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
    //   }
    // );
  }
}