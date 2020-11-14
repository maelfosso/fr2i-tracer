import 'package:flutter/material.dart';

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
                // color: Colors.pink,
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
            "Picture",
            style: Theme.of(context).textTheme.headline5
          ),
        ),
        Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.spaceBetween,
          children: [
            _buildFeatureItem(Icons.add_a_photo ,"Take a picture", () {
              print("Taped on TAKE A PICTURE");
            }),
            _buildFeatureItem(Icons.send, "Send a picture", () {
              print("Taped on TAKE A PICTURE");
            }),
            _buildFeatureItem(Icons.toys, "Classify a picture", () {
              print("Taped on TAKE A PICTURE");
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
              print("Taped on ENTER A DATA");
            }),
            _buildFeatureItem(Icons.all_out, "All your data", () {
              print("Taped on ALL YOUR DATA");
            })
          ]
        )
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}