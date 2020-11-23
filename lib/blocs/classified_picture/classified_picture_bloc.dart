import 'dart:async';
import 'dart:collection';
import 'package:bloc/bloc.dart';
import 'package:tflite/tflite.dart';
import 'package:tracer/blocs/classified_picture/classified_picture.dart';
import 'package:tracer/models/models.dart';

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
    List<Result> outputs = [];
    await loadModel();

    List values = await Tflite.runModelOnImage(
      path: event.imagePath,
      numResults: 5,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5
    );
    outputs.clear();
    outputs = values.map((e) => Result(e['confidence'], e['index'], e['label']));
    outputs.sort((a, b) => a.confidence.compareTo(b.confidence));

    yield ClassifiedPictureSuccess(outputs, event.imagePath);
  }

  Future loadModel() async {
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
