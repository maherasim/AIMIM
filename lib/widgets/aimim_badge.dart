import 'package:flutter/material.dart';

class AimimBadge extends StatelessWidget {
  const AimimBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 18,
            height: 18,
            child: CustomPaint(painter: _MiniKitePainter()),
          ),
          const SizedBox(width: 5),
          const Text(
            'AIMIM',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class KitePainter extends CustomPainter {
  final Color color;
  const KitePainter({this.color = Colors.white});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    // Kite body — tilted square (diamond rotated slightly)
    final kite = Path()
      ..moveTo(w * 0.55, 0)           // top
      ..lineTo(w, h * 0.40)           // right
      ..lineTo(w * 0.80, h * 0.78)    // bottom
      ..lineTo(w * 0.05, h * 0.62)    // left
      ..close();
    canvas.drawPath(kite, paint);

    // Diagonal cross lines inside kite
    canvas.drawLine(Offset(w * 0.55, 0), Offset(w * 0.80, h * 0.78), paint);
    canvas.drawLine(Offset(w, h * 0.40), Offset(w * 0.05, h * 0.62), paint);

    // Two hole-dots
    final dot = Paint()..color = color..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.60, h * 0.25), w * 0.09, dot);
    canvas.drawCircle(Offset(w * 0.68, h * 0.54), w * 0.08, dot);

    // Stick handle
    final stick = Paint()
      ..color = color
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(w * 0.05, h * 0.62), Offset(0, h * 0.85), stick);

    // Tassels
    final tassel = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 4; i++) {
      canvas.drawLine(
        Offset(w * 0.02, h * 0.86),
        Offset(w * 0.02 - 10 + i * 7.0, h),
        tassel,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MiniKitePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;

    final path = Path()
      ..moveTo(w * 0.55, 0)
      ..lineTo(w, h * 0.40)
      ..lineTo(w * 0.80, h * 0.80)
      ..lineTo(w * 0.05, h * 0.62)
      ..close();
    canvas.drawPath(path, paint);
    canvas.drawLine(Offset(w * 0.55, 0), Offset(w * 0.80, h * 0.80), paint);
    canvas.drawLine(Offset(w, h * 0.40), Offset(w * 0.05, h * 0.62), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
