import 'package:flutter/material.dart';

import '../../../features/identify/presentation/pages/identify_page.dart';
import 'gradient_bg.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() =>
      _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fade = CurvedAnimation(
      parent: _c,
      curve: Curves.easeOut,
    );
    _scale = Tween<double>(begin: 0.96, end: 1.0)
        .animate(
          CurvedAnimation(
            parent: _c,
            curve: Curves.easeOutCubic,
          ),
        );
    _c.forward();
    Future.delayed(
      const Duration(milliseconds: 1100),
      () {
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const IdentifyPage(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedAnifyBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: FadeTransition(
            opacity: _fade,
            child: ScaleTransition(
              scale: _scale,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.pets,
                    color: Colors.white,
                    size: 84,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Anify',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
