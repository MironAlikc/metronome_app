import 'package:flutter/material.dart';
import 'package:metronome_app/metronome_wand_painter.dart';

enum MetronomeState {
  Playing,
  Stopped,
  Stopping,
}

class MetronomeControl extends StatefulWidget {
  MetronomeControl();
  MetronomeControlState createState() => new MetronomeControlState();
}

class MetronomeControlState extends State<MetronomeControl> {
  MetronomeControlState();

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: 20),
          Expanded(child: LayoutBuilder(builder: (context, constraints) {
            double aspectRatio = 1.5; // height:width
            double width =
                (constraints.maxHeight >= constraints.maxWidth * aspectRatio)
                    ? constraints.maxWidth
                    : constraints.maxHeight / aspectRatio;
            double height =
                (constraints.maxHeight >= constraints.maxWidth * aspectRatio)
                    ? width * aspectRatio
                    : constraints.maxHeight;

            return _wand(width, height);
            //  Container(
            //     // this is the 1.5 aspect ratio box, the metronome is going to be drawn into
            //     width: width,
            //     height: height,
            //     decoration: BoxDecoration(
            //         shape: BoxShape.rectangle, color: Colors.orange));
          })),
          Container(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton(
              // color: Colors.purple,
              // textColor: Colors.white,
              child: Text("Start"),
              onPressed: () {},
            ),
            ElevatedButton(
              // color: Colors.purple,
              // textColor: Colors.white,
              child: Text("Tap"),
              onPressed: () {},
            ),
          ]),
          SizedBox(height: 20),
        ]);
  }

  Widget _wand(double width, double height) {
    return Container(
      width: width,
      height: height,
      child: GestureDetector(
        onPanDown: (dragDownDetails) {/*TODO*/},
        onPanUpdate: (dragUpdateDetails) {/*TODO*/},
        onPanEnd: (dragEndDetails) {/*TODO*/},
        onPanCancel: () {/*TODO*/},
        child: CustomPaint(
          foregroundPainter: MetronomeWandPainter(
            width: width,
            height: height,
            tempo: 60,
            minTempo: 30,
            maxTempo: 220,
            rotationAngle: 50,
          ),
          child: const InkWell(),
        ),
      ),
    );
  }
}
