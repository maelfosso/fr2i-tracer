import 'package:equatable/equatable.dart';

abstract class ClassifiedPictureEvent extends Equatable {
  const ClassifiedPictureEvent();
}

class ClassifiedPictureStarted extends ClassifiedPictureEvent {
  final String imagePath;

  const ClassifiedPictureStarted(this.imagePath);

  @override
  List<Object> get props => [imagePath];

  @override
  String toString() => 'ClassifiedPictureStarted { imagePath: $imagePath }';
}
