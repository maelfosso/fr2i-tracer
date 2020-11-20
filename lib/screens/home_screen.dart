import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracer/blocs/data/data_bloc.dart';
import 'package:tracer/screens/classify_picture_screen.dart';
import 'package:tracer/screens/gallery_screen.dart';
import 'package:tracer/screens/keys.dart';

class HomeScreen extends StatelessWidget {

  Widget _buildFeatureItem(IconData icon, String name, VoidCallback callback) {
    return Card(
      child: InkWell(
        onTap: callback,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Column(
            children: [
              Icon(
                icon,
                size: 32.0,
                semanticLabel: name,
              ),
              Text(name)
            ],
          ),
        )
      )
    );
  }

  Widget _imagesFeatures(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Pictures",
            style: Theme.of(context).textTheme.headline5
          ),
        ),
        Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.spaceBetween,
          children: [
            _buildFeatureItem(Icons.add_a_photo ,"Take a picture", () {
              Navigator.pushNamed(context, ArchSampleRoutes.takePicture);
            }),
            _buildFeatureItem(Icons.send, "Send a picture", () {
              print("Taped on TAKE A PICTURE");
            }),
            _buildFeatureItem(Icons.toys, "Classify a picture", () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) {
                  return ClassifyPictureScreen();
                }),
              );
            })  
          ]
        )
      ]
    );
  }

  Widget _dataFeatures(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Data",
            style: Theme.of(context).textTheme.headline5
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildFeatureItem(Icons.add ,"Enter a data", () {
              Navigator.pushNamed(context, ArchSampleRoutes.addData);
            }),
            _buildFeatureItem(Icons.all_out, "All your data", () {
              Navigator.pushNamed(context, ArchSampleRoutes.listData);
            })
          ]
        )
      ]
    );
  }

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
          child: Column(
            children: [
              _imagesFeatures(context),
              _dataFeatures(context)
            ],
          )
        )
      )
    );
  }
}
