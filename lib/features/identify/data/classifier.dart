import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart'
    show rootBundle;
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

import '../domain/prediction.dart';

class Classifier {
  final int inputSize = 224;
  Interpreter? _interpreter;
  late List<String> _labels;

  Future<void> load() async {
    // Load TFLite model once
    _interpreter ??= await Interpreter.fromAsset(
      'assets/model/animal_classifier.tflite',
    );

    // Load class labels (order must match model outputs)
    final labelsJson = await rootBundle
        .loadString(
          'assets/model/class_names_animals.json',
        );
    _labels = (json.decode(labelsJson) as List)
        .map((e) => e.toString())
        .toList();
  }

  Future<Prediction> classify(File file) async {
    if (_interpreter == null) {
      await load();
    }

    // 1) Decode and resize image to model input
    final bytes = await file.readAsBytes();
    final img.Image? decoded = img.decodeImage(
      bytes,
    );
    if (decoded == null) {
      throw Exception('Unable to decode image');
    }
    final img.Image resized = img.copyResize(
      decoded,
      width: inputSize,
      height: inputSize,
    );

    // 2) Build input tensor [1,224,224,3] with float32 normalized to [0,1]
    final input = List.generate(
      1,
      (_) => List.generate(
        inputSize,
        (y) => List.generate(inputSize, (x) {
          final p = resized.getPixel(
            x,
            y,
          ); // image 4.x Pixel
          return [
            p.r / 255.0,
            p.g / 255.0,
            p.b / 255.0,
          ];
        }),
      ),
    );

    // 3) Prepare output buffer
    final outShape = _interpreter!
        .getOutputTensor(0)
        .shape; // [1, numClasses]
    final numClasses = outShape.last;
    final output = List.filled(
      numClasses,
      0.0,
    ).reshape([1, numClasses]);

    // 4) Inference
    _interpreter!.run(input, output);

    // 5) Top-1 selection
    final scores = (output[0] as List<double>);
    int best = 0;
    double bestScore = scores[0];
    for (int i = 1; i < scores.length; i++) {
      if (scores[i] > bestScore) {
        best = i;
        bestScore = scores[i];
      }
    }

    // 6) Map to human label (expected labels: "cat", "dog", "wildlife")
    final raw =
        (best >= 0 && best < _labels.length)
        ? _labels[best]
        : 'unknown';
    final display = _titleCase(raw);

    // 7) Return prediction (UI/tts will speak only the label)
    return Prediction(
      fineLabel: display,
      coarseLabel: display,
      confidence: bestScore, // 0..1
      path: file.path,
    );
  }

  void dispose() {
    _interpreter?.close();
  }

  String _titleCase(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() +
        s.substring(1).toLowerCase();
  }
}
