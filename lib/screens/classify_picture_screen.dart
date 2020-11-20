import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracer/blocs/data/data.dart';
import 'package:tracer/blocs/upload_data/upload_data.dart';
import 'package:tracer/models/models.dart';
import 'package:tracer/screens/add_edit_data_screen.dart';
import 'package:tracer/screens/details_screen.dart';
import 'package:tracer/screens/keys.dart';
import 'package:tracer/widgets/data_item.dart';
import 'package:tracer/widgets/gallery_widget.dart';
import 'package:tracer/widgets/loading_indicator.dart';
import 'package:tracer/widgets/upload_data_dialog.dart';

class ClassifyPictureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Classify Picture")
      ),
      body: GalleryWidget(),
    );
  }
}