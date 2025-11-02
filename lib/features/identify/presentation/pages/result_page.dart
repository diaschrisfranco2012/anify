import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/gradient_bg.dart';
import '../../domain/prediction.dart';
import '../widgets/confidence_bar.dart';

class ResultPage extends StatefulWidget {
  final Prediction prediction;
  const ResultPage({
    super.key,
    required this.prediction,
  });

  @override
  State<ResultPage> createState() =>
      _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final _tts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _tts.setLanguage('en-US');
    _tts.setSpeechRate(0.45);
    _tts.setPitch(1.0);
    _speak();
  }

  Future<void> _speak() async {
    final text =
        "It's a ${widget.prediction.coarseLabel}.";
    await _tts.stop();
    await _tts.speak(text);
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.prediction;
    return AnimatedAnifyBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Result'),
          actions: [
            IconButton(
              icon: const Icon(
                Symbols.volume_up_rounded,
              ),
              onPressed: _speak,
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              10,
              20,
              20,
            ),
            child: Column(
              children: [
                ConstrainedBox(
                  constraints:
                      const BoxConstraints(
                        maxWidth: 420,
                      ),
                  child: GlassCard(
                    padding: const EdgeInsets.all(
                      14,
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .stretch,
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(
                                16,
                              ),
                          child: Image.file(
                            File(p.path),
                            fit: BoxFit.cover,
                            height: 260,
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Row(
                          children: [
                            Chip(
                              label: Text(
                                p.coarseLabel,
                              ),
                              backgroundColor:
                                  Colors.white
                                      .withValues(
                                        alpha:
                                            0.12,
                                      ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Spacer(),
                            Text(
                              '${(p.confidence * 100).toStringAsFixed(1)}%',
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ConfidenceBar(
                          value: p.confidence,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ConstrainedBox(
                  constraints:
                      const BoxConstraints(
                        maxWidth: 420,
                      ),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () =>
                              Navigator.pop(
                                context,
                              ),
                          icon: const Icon(
                            Symbols
                                .refresh_rounded,
                          ),
                          label: const Text(
                            'Try Again',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _speak,
                          icon: const Icon(
                            Symbols
                                .volume_up_rounded,
                          ),
                          label: const Text(
                            'Hear Again',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
