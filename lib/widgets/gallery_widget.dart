import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

typedef OnTapCallback = Function(
  String imagePath
);

class GalleryWidget extends StatefulWidget {
  
  final OnTapCallback onTap;

  const GalleryWidget({
    Key key,
    @required this.onTap,
  }): super(key: key);

  GalleryWidgetState createState() => GalleryWidgetState();

}

class GalleryWidgetState extends State<GalleryWidget> {

  List<FileSystemEntity> _images = [];

  @override
  void initState() {
    super.initState();

    print('\nINTO INIT STATE');

    _getAllImages();
  }

  void _getAllImages() async {
    print('\nINTO ALL IMAGES');

    final path = join(
      // Store the picture in the temp directory.
      // Find the temp directory using the `path_provider` plugin.
      (await getApplicationDocumentsDirectory()).path,
      'pictures',
    );
    print('\nPATH ... $path');

    try {
      final myDir = new Directory(path);
      setState(() {
        _images =  myDir.listSync(recursive: false, followLinks: false) ?? [];
      });
      print('\nALL IMAGE $_images');
    } catch (e) {
      print('\nAN ERROR OCCURRED');
      print(e);
      _images = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    print('\nAfter image... $_images');

    return Container(
        padding: EdgeInsets.zero,
        color: Colors.white,
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 6.0,
          children: _images.map((image) {
            print('\nImage mapping $image');

            return GridTile(
              child: GestureDetector(
                onTap: () {
                  widget.onTap(image.path);
                },
                child: Hero(
                  tag: image.path.toString(),
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(File(image.path)),
                    ),
                  ),
                ),
              ),
            );
          }).toList()
        )
      
    );
  }
}