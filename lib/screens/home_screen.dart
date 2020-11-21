import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracer/blocs/data/data_bloc.dart';
import 'package:tracer/screens/keys.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<DataBloc>(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tracer")
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: [
              ListTile(
                title: Text(
                  "Pictures",
                  style: Theme.of(context).textTheme.headline5
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.add_a_photo,
                  size: 32.0,
                ),
                title: Text(
                  "Take a picture",
                  // style: Theme.of(context).textTheme.headline5
                ),
                onTap: () {
                  Navigator.pushNamed(context, ArchSampleRoutes.takePicture);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.send,
                  size: 32.0,
                ),
                title: Text(
                  "Send a picture",
                  // style: Theme.of(context).textTheme.headline5
                ),
                onTap: () {
                  Scaffold.of(context).showSnackBar(SnackBar(
                      duration: Duration(seconds: 3),
                      content: Text(
                        "Feature not implemented",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis
                      )
                    )
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.toys,
                  size: 32.0,
                ),
                title: Text(
                  "Classify a picture",
                  // style: Theme.of(context).textTheme.headline5
                ),
                onTap: () {
                  Navigator.pushNamed(context, ArchSampleRoutes.classifyPicture);
                },
              ),


              ListTile(
                title: Text(
                  "Data",
                  style: Theme.of(context).textTheme.headline5
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.add_a_photo,
                  size: 32.0,
                ),
                title: Text(
                  "Enter a data",
                  // style: Theme.of(context).textTheme.headline5
                ),
                onTap: () {
                  Navigator.pushNamed(context, ArchSampleRoutes.addData);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.send,
                  size: 32.0,
                ),
                title: Text(
                  "All your data",
                  // style: Theme.of(context).textTheme.headline5
                ),
                onTap: () {
                  Navigator.pushNamed(context, ArchSampleRoutes.listData);
                },
              ),            
            ],
          )
        )
      )
    );
  }
}
