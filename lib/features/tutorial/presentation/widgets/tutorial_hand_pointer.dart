import 'package:flutter/material.dart';

/// Animasyonlu el/parmak işaretçisi.
/// Kullanıcıya nereye tıklaması gerektiğini gösterir.
class TutorialHandPointer extends StatefulWidget {
  const TutorialHandPointer({
    super.key,
    this.size = 48,
  });

  final double size;

  @override
  State<TutorialHandPointer> createState() => _TutorialHandPointerState();
}

class _TutorialHandPointerState extends State<TutorialHandPointer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _bounceAnimation = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _bounceAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _bounceAnimation.value),
          child: Icon(
            Icons.touch_app,
            size: widget.size,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        );
      },
    );
  }
}
