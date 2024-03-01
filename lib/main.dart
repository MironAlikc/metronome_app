import 'package:flutter/material.dart';
import 'package:metronome_app/metronome_controls.dart';

//import "Progress.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Metronome',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Scaffold(
        // backgroundColor: Colors.green,
        appBar: AppBar(
            //title: const Text("Metronome"),
            ),
        body: const MetronomeControl(),
      ),
    );
  }
}
