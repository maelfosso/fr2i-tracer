import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracer/blocs/classified_picture/classified_picture.dart';
import 'package:tracer/widgets/loading_indicator.dart';

class ClassifyPictureBottomSheet extends StatelessWidget {

  ClassifyPictureBottomSheet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassifiedPictureBloc, ClassifiedPictureState>(
      builder: (context, state) {
        if (state is ClassifiedPictureStarted) {
          return LoadingIndicator();
        } else if (state is ClassifiedPictureSuccess) {
          String imagePath = state.imagePath;
          List outputs = state.outputs;
          print(outputs);
          return Column(
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.file(File(imagePath))
                )
              ),
              ListView(

              )
            ],
          ); 
        }

        return Container();
      },
    );
  }
}
