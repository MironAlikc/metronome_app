import 'package:flutter/material.dart';
import 'package:metronome_app/wand_coords.dart';
import 'dart:ui' as ui;

class MetronomeWandPainter extends CustomPainter {
  // props required for painting
  double rotationAngle;
  final double width;
  final double height;
  final int tempo;
  final int minTempo;
  final int maxTempo;

  final Color _bobTextColor = Colors.white;
  late Map<String, Paint> paints;

  MetronomeWandPainter({
    required this.rotationAngle,
    required this.width,
    required this.height,
    required this.tempo,
    required this.minTempo,
    required this.maxTempo,
  }) {
    _initFillsAndPaints();
  }

  _initFillsAndPaints() {
    paints = {
      "strokeBase": Paint()
        ..color = Colors.black
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = width * 0.015,
      "fillCounterWeight": Paint()
        ..color = Colors.deepPurple
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.fill,
      "fillRotationCenter": Paint()
        ..color = Colors.black
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.fill,
      "fillBob": Paint()
        ..color = Colors.teal
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.fill,
    };
  }

  @override
  void paint(Canvas canvas, Size size) {
    // shift the canvas to put the origin where we want the rotation center to be.
    canvas.translate(width / 2, height * .75);
    canvas.rotate(rotationAngle);
    _drawWandOnCanvas(canvas);
    _drawWandOnCanvas(canvas);
  }

  _drawWandOnCanvas(Canvas canvas) {
    WandCoords wandCoords =
        WandCoords(width, height, tempo, minTempo, maxTempo);

    List<Offset> bobPoints = List.empty(growable: true)
      ..add(Offset(wandCoords.bobCenter.dx + width / 8,
          wandCoords.bobCenter.dy + height / 20))
      ..add(Offset(wandCoords.bobCenter.dx - width / 8,
          wandCoords.bobCenter.dy + height / 20))
      ..add(Offset(wandCoords.bobCenter.dx - width / 6,
          wandCoords.bobCenter.dy - height / 20))
      ..add(Offset(wandCoords.bobCenter.dx + width / 6,
          wandCoords.bobCenter.dy - height / 20));

    Path bobPath = Path()..addPolygon(bobPoints, true);
    ui.ParagraphBuilder paragraphBuilder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textDirection: TextDirection.ltr,
        fontSize: width / 15,
        textAlign: TextAlign.left,
      ),
    )
      ..pushStyle(ui.TextStyle(color: _bobTextColor))
      ..addText('$tempo');

    ui.Paragraph paragraph = paragraphBuilder.build()
      ..layout(ui.ParagraphConstraints(width: width / 4));

    Offset paragraphPos = Offset(
        wandCoords.bobCenter.dx - paragraph.maxIntrinsicWidth / 2.0,
        wandCoords.bobCenter.dy - paragraph.height / 2.0);

    canvas.drawLine(
        wandCoords.stickTop, wandCoords.stickBottom, paints["strokeBase"]!);
    canvas.drawCircle(wandCoords.rotationCenter,
        wandCoords.rotationCenterRadius, paints["fillRotationCenter"]!);
    canvas.drawCircle(wandCoords.counterWeightCenter,
        wandCoords.counterWeightRadius, paints["fillCounterWeight"]!);
    canvas.drawCircle(wandCoords.counterWeightCenter,
        wandCoords.counterWeightRadius, paints["strokeBase"]!);
    canvas.drawPath(bobPath, paints["fillBob"]!);
    canvas.drawPath(bobPath, paints["strokeBase"]!);
    canvas.drawParagraph(paragraph, paragraphPos);
  }

  @override
  bool shouldRepaint(MetronomeWandPainter oldDelegate) {
    return true;
  }
}
