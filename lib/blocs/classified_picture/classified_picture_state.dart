
import 'package:equatable/equatable.dart';
import 'package:tracer/models/models.dart';

abstract class ClassifiedPictureState extends Equatable {
  const ClassifiedPictureState();

  @override
  List<Object> get props => [];
}

class ClassifiedPictureInProgress extends ClassifiedPictureState {}

class ClassifiedPictureSuccess extends ClassifiedPictureState {
  final List<Result> outputs;
  final String imagePath;

  const ClassifiedPictureSuccess(
    this.outputs,
    this.imagePath
  );

  @override
  List<Object> get props => [outputs];

  @override
  String toString() {
    return 'ClassifiedPictureSuccess { outputs: $outputs, imagePath: $imagePath }';
  }
}
