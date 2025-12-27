import 'dart:math';
import 'package:flutter/material.dart';

class BubblesScreen extends StatefulWidget {
  const BubblesScreen({super.key});

  @override
  State<BubblesScreen> createState() => _BubblesScreenState();
}

class _BubblesScreenState extends State<BubblesScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (ctx, _) {
          return CustomPaint(
            painter: _RadarPainter(progress: _controller.value),
            size: const Size(320, 320),
          );
        },
      ),
    );
  }
}

class _RadarPainter extends CustomPainter {
  final double progress;
  _RadarPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;
    final bgPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = const LinearGradient(
        colors: [Color(0xFF191970), Color(0xFF7851A9)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, bgPaint);

    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white.withOpacity(0.25)
      ..strokeWidth = 2;
    for (var r = radius * 0.2; r <= radius; r += radius * 0.2) {
      canvas.drawCircle(center, r, ringPaint);
    }

    final sweepPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..color = Colors.white.withOpacity(0.6)
      ..strokeWidth = 3;
    final sweepAngle = progress * 2 * pi;
    final sweepRadius = radius * 0.9;
    final sweepEnd = Offset(
      center.dx + sweepRadius * cos(sweepAngle),
      center.dy + sweepRadius * sin(sweepAngle),
    );
    canvas.drawLine(center, sweepEnd, sweepPaint);

    final dotPaint = Paint()..color = Colors.white.withOpacity(0.9);
    for (var i = 0; i < 16; i++) {
      final ang = (i / 16.0) * 2 * pi;
      final dist = radius * (0.2 + (i % 4) * 0.2);
      final pulse = 1 + 0.08 * sin(progress * 2 * pi + i);
      final pos = Offset(
        center.dx + dist * cos(ang),
        center.dy + dist * sin(ang),
      );
      canvas.drawCircle(pos, 4 * pulse, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _RadarPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
