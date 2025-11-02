import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/gradient_bg.dart';
import '../../application/identify_controller.dart';
import '../../data/classifier.dart';
import '../widgets/action_tile.dart';
import 'result_page.dart';

class IdentifyPage extends StatefulWidget {
  const IdentifyPage({super.key});

  @override
  State<IdentifyPage> createState() =>
      _IdentifyPageState();
}

class _IdentifyPageState
    extends State<IdentifyPage> {
  late final IdentifyController controller;
  final classifier = Classifier();
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    controller = IdentifyController(classifier);
    classifier.load();
  }

  Future<void> _handlePick(bool camera) async {
    if (_busy) return;
    setState(() => _busy = true);
    final prediction = camera
        ? await controller.pickFromCamera()
        : await controller.pickFromGallery();
    setState(() => _busy = false);
    if (!mounted || prediction == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            ResultPage(prediction: prediction),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedAnifyBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                20,
                24,
                20,
                20,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 420,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Anify',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight:
                            FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Identify animals instantly',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    GlassCard(
                      child: Column(
                        children: [
                          const Text(
                            'Pick an option',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.w800,
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ActionTile(
                                  title:
                                      'Take Photo',
                                  icon: Symbols
                                      .camera_rounded,
                                  onTap: () =>
                                      _handlePick(
                                        true,
                                      ),
                                ),
                              ),
                              const SizedBox(
                                width: 14,
                              ),
                              Expanded(
                                child: ActionTile(
                                  title:
                                      'Upload Image',
                                  icon: Symbols
                                      .photo_library_rounded,
                                  onTap: () =>
                                      _handlePick(
                                        false,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          if (_busy) ...[
                            const SizedBox(
                              height: 14,
                            ),
                            const LinearProgressIndicator(
                              minHeight: 4,
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      '© 2025 Anify • Designed with care',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
