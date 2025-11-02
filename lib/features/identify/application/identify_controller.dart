import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../data/classifier.dart';
import '../domain/prediction.dart';

class IdentifyController {
  final Classifier classifier;
  final _picker = ImagePicker();

  IdentifyController(this.classifier);

  Future<Prediction?> pickFromCamera() async {
    final x = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 95,
    );
    if (x == null) return null;
    final file = File(x.path);
    return await classifier.classify(file);
  }

  Future<Prediction?> pickFromGallery() async {
    final x = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 95,
    );
    if (x == null) return null;
    final file = File(x.path);
    return await classifier.classify(file);
  }

  Future<void> dispose() async {
    // nothing to dispose now
  }
}
