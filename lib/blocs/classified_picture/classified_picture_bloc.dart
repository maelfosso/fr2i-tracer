import 'dart:async';
import 'dart:collection';
import 'package:bloc/bloc.dart';
import 'package:tflite/tflite.dart';
import 'package:tracer/blocs/classified_picture/classified_picture.dart';

class ClassifiedPictureBloc extends Bloc<ClassifiedPictureEvent, ClassifiedPictureState> {
  
  ClassifiedPictureBloc()
      : super(ClassifiedPictureInProgress());

  @override
  Stream<ClassifiedPictureState> mapEventToState(ClassifiedPictureEvent event) async* {
    if (event is ClassifiedPictureStarted) {
      yield* _mapClassifiedPictureStartedToState(event);
    }
  }

  Stream<ClassifiedPictureState> _mapClassifiedPictureStartedToState(
    ClassifiedPictureStarted event,
  ) async* {
    await loadModel();

    print('\nMODEL LOADED... ${event.imagePath}');

    List outputs = await Tflite.runModelOnImage(
      path: event.imagePath,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5
    );

    yield ClassifiedPictureSuccess(outputs, event.imagePath);
  }

  Future loadModel() async {
    // print('\nLET CLOSE IT FIRST');
    // Tflite.close();
    print('\nLET TRY TO LOAD IT');
    try {
      String res = await Tflite.loadModel(
        model: "assets/furniture-classification-model.tflite",
        labels: "assets/labels.txt",
      );
      print('\nLOAD MODEL ... $res');
    } on Exception {
      print('\nFAILED TO LOAD MODEL');
    }
  }

}
