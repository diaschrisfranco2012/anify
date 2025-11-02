class Prediction {
  final String fineLabel;
  final String
  coarseLabel; // Cat / Dog / Wildlife
  final double confidence; // 0..1
  final String path; // image path

  Prediction({
    required this.fineLabel,
    required this.coarseLabel,
    required this.confidence,
    required this.path,
  });
}
