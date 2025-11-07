import 'package:flutter/material.dart';

class AnimatedAnifyBackground
    extends StatefulWidget {
  final Widget child;
  const AnimatedAnifyBackground({
    super.key,
    required this.child,
  });

  @override
  State<AnimatedAnifyBackground> createState() =>
      _AnimatedAnifyBackgroundState();
}

class _AnimatedAnifyBackgroundState
    extends State<AnimatedAnifyBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<Color?> _c1;
  late final Animation<Color?> _c2;
  late final Animation<Alignment> _begin;
  late final Animation<Alignment> _end;

  @override
  void initState() {
    super.initState();
    // Slow, premium motion. Increase to 36s if you want even calmer.
    _c = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 28),
    )..repeat(reverse: true);

    // Color tweens (tech blues with a hint of violet)
    _c1 =
        ColorTween(
          begin: const Color(0xFF5B3FD9),
          end: const Color(0xFF8E6FFF),
        ).animate(
          CurvedAnimation(
            parent: _c,
            curve: Curves.easeInOut,
          ),
        );

    _c2 =
        ColorTween(
          begin: const Color(0xFFFF6FB1),
          end: const Color(0xFFFFA6C1),
        ).animate(
          CurvedAnimation(
            parent: _c,
            curve: Curves.easeInOut,
          ),
        );

    // Subtle drift of gradient direction to add parallax feel without moving content
    _begin =
        AlignmentTween(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ).animate(
          CurvedAnimation(
            parent: _c,
            curve: Curves.easeInOut,
          ),
        );

    _end =
        AlignmentTween(
          begin: Alignment.bottomRight,
          end: Alignment.bottomLeft,
        ).animate(
          CurvedAnimation(
            parent: _c,
            curve: Curves.easeInOut,
          ),
        );
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (_, __) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _c1.value ??
                    const Color(0xFF0B1020),
                _c2.value ??
                    const Color(0xFF1F7AE0),
              ],
              begin: _begin.value,
              end: _end.value,
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
              // soft radial bloom on the top area
              gradient: RadialGradient(
                center: Alignment(0.4, -0.9),
                radius: 1.0,
                colors: [
                  Color(0x14FFFFFF),
                  Color(0x00000000),
                ],
              ),
            ),
            child: widget.child,
          ),
        );
      },
    );
  }
}

// Optional wrapper for legacy references
class AnimatedGreenBackground
    extends StatelessWidget {
  final Widget child;
  const AnimatedGreenBackground({
    super.key,
    required this.child,
  });
  @override
  Widget build(BuildContext context) =>
      AnimatedAnifyBackground(child: child);
}
