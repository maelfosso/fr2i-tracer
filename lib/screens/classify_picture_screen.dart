import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tracer/widgets/gallery_widget.dart';

class ClassifyPictureScreen extends StatelessWidget {
  String selectedImagePath;

  void _displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(context).size.height  * 0.4,
          child: Column(
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.file(File(this.selectedImagePath)) 
                  // Image(
                  //   File(this.selectedImagePath)
                  // )
                  // Image.network(
                  //     subject['images']['large'],
                  //     height: 150.0,
                  //     width: 100.0,
                  // ),
                )
                // new Container(
                //   width: 190.0,
                //   height: 190.0,
                //   decoration: new BoxDecoration(
                //     shape: BoxShape.circle,
                //     image: new DecorationImage(
                //       fit: BoxFit.fill,
                //       image: FileImage(File(this.selectedImagePath))
                //     )
                //   )
                // ),
              ),
              ListView(

              )
            ],
          ) 
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Classify Picture")
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                'Tap on the image to classify it',
                style: Theme.of(context).textTheme.headline6
              ),
            ),
            GalleryWidget(
              onTap: (imagePath) {
                print('\nImagePath... $imagePath');
                this.selectedImagePath = imagePath;

                _displayBottomSheet(context);
              },
            ),
          ]
        )
      )
    );
  }
}