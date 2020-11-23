import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracer/blocs/classified_picture/classified_picture.dart';
import 'package:tracer/models/models.dart';
import 'package:tracer/widgets/loading_indicator.dart';

class ClassifyPictureBottomSheet extends StatefulWidget {
  ClassifyPictureBottomSheet({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ClassifyPictureBottomSheetState createState() => _ClassifyPictureBottomSheetState();
}

class _ClassifyPictureBottomSheetState extends State<ClassifyPictureBottomSheet>
    with TickerProviderStateMixin {
  AnimationController _colorAnimController;
  Animation _colorTween;

  List<Result> outputs;

  void initState() {
    super.initState();

    //Setup Animation
    _setupAnimation();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder<ClassifiedPictureBloc, ClassifiedPictureState>(
        builder: (context, state) {
          if (state is ClassifiedPictureStarted) {
            return LoadingIndicator();
          } else if (state is ClassifiedPictureSuccess) {
            String imagePath = state.imagePath;
            List outputs = state.outputs; 

            return Column(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.file(File(imagePath))
                  )
                ),
                _buildResultsWidget(width, outputs)
              ],
            ); 
          }

          return Container();
        },
      ),
    );
  }

  Widget _buildResultsWidget(double width, List<Result> outputs) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 200.0,
          width: width,
          color: Colors.white,
          child: outputs != null && outputs.isNotEmpty
              ? ListView.builder(
                  itemCount: outputs.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20.0),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        Text(
                          outputs[index].label,
                          style: TextStyle(
                            color: _colorTween.value,
                            fontSize: 20.0,
                          ),
                        ),
                        AnimatedBuilder(
                            animation: _colorAnimController,
                            builder: (context, child) => LinearPercentIndicator(
                                  width: width * 0.88,
                                  lineHeight: 14.0,
                                  percent: outputs[index].confidence,
                                  progressColor: _colorTween.value,
                                )),
                        Text(
                          "${(outputs[index].confidence * 100.0).toStringAsFixed(2)} %",
                          style: TextStyle(
                            color: _colorTween.value,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    );
                  })
              : Center(
                  child: Text("Wating for model to detect..",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ))),
        ),
      ),
    );
  }

  void _setupAnimation() {
    _colorAnimController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _colorTween = ColorTween(begin: Colors.green, end: Colors.red)
        .animate(_colorAnimController);
  }
}
