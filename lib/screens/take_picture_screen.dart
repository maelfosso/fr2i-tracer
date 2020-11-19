import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:tracer/screens/home_screen.dart';
import 'package:tracer/screens/keys.dart';


class TakePictureScreen extends StatefulWidget {
  // final CameraDescription camera;

  const TakePictureScreen({
    Key key,
    // @required this.camera,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    final firstCamera = GetIt.I.get<CameraDescription>();

    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      firstCamera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Construct the path where the image should be saved using the
            // pattern package.
            final path = join(
              // Store the picture in the temp directory.
              // Find the temp directory using the `path_provider` plugin.
              (await getApplicationDocumentsDirectory()).path,
              '${DateTime.now()}.png',
            );
            print('\nTake picture for ${path}');
            // Attempt to take a picture and log where it's been saved.
            await _controller.takePicture(path);
            print('\nPicture Taken...');
            // If the picture was taken, display it on a new screen.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: path),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  void _deleteImage() async {
    print('\nDelete Image ${imagePath}');
    File file = File(imagePath);

    try {
      await file.delete();
      print('\nFile ${imagePath} deleted');
    } catch(e) {
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Center(
            child: Hero(
              tag: 'dash',
              child: Image.file(File(imagePath), height: size.height, width: size.width, fit: BoxFit.fill),
            )
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatButton(
                  textColor: Colors.white,
                  child: Text('CANCEL'),
                  onPressed: () {
                    _deleteImage();

                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  textColor: Colors.white,
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.popUntil(context, 
                      ModalRoute.withName('/')
                    );
                  },
                )
              ],
            )
          )
        ],
      )  
    );
  }
}
