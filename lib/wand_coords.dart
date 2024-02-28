import 'package:flutter/material.dart';

class WandCoords {
  late Offset bobCenter;
  late Offset counterWeightCenter;
  late double counterWeightRadius;
  late Offset stickTop;
  late Offset stickBottom;
  late Offset rotationCenter;
  late double rotationCenterRadius;
  late double bobMinY;
  late double bobMaxY;
  late double bobTravel;

  // calculates all coordinates relative to the rotation center and scaled based on height and width.
  WandCoords(
      double width, double height, int tempo, int minTempo, int maxTempo) {
    rotationCenter = Offset(0, 0);
    rotationCenterRadius = width / 40;

    counterWeightCenter = Offset(0, height * 0.175);
    counterWeightRadius = width / 12;

    stickTop = Offset(0, -height * 0.68);
    stickBottom = Offset(0, height * 0.175);

    double bobHeight = height / 15;
    bobMinY = stickTop.dy;
    bobMaxY = rotationCenter.dy - rotationCenterRadius - bobHeight / 2 - 2;
    bobTravel = bobMaxY - bobMinY;
    double tempoPercent = (tempo - minTempo) / (maxTempo - minTempo);
    double bobPercent = tempoPercent;
    bobCenter = Offset(0, bobMinY + (bobTravel * bobPercent));
  }
}
