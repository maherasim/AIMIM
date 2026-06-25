import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import '../widgets/aimim_badge.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromRGBO(13, 83, 55, 1),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // White Background Layer
          CustomPaint(painter: _WhiteBackgroundPainter()),

          // 1. Top Section (India + Badge)
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 90,
                      height: 110,
                      child: SvgPicture.asset('assets/svg/india-map.svg'),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.2),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SvgPicture.asset(
                        'assets/svg/Logo.svg',
                        width: 150,
                        height: 38,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 2. Kite (Centered in top green section)
          Positioned(
            top: size.height * 0.20,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 150,
                height: 150,
                child: SvgPicture.asset(
                  'assets/svg/kite.svg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),

          // 3. Middle White Section Content
          Positioned(
            top: size.height * 0.34,
            left: 16,
            right: 16,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Column(
                  children: [
                    Text(
                      'AIMIM',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.rubikMoonrocks(
                        fontSize: 115,

                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(13, 83, 55, 1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: size.height * 0.50,
            left: 12,
            right: 16,
            child: Text(
              'NATIONAL MEMBERSHIP PLATFORM',
              textAlign: TextAlign.center,
              style: GoogleFonts.rubikMoonrocks(
                fontSize: 19.5,

                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(13, 83, 55, 1),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.56,
            left: 12,
            right: 16,
            child: Text(
              'True Democracy\n Every Citizen Matters, Beyond Identity',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 20,

                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.66,
            left: 70,
            right: 70,
            child: Container(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(13, 83, 55, 1),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'GET STARTED',
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          // 4. Bottom Green Section
          Positioned(
            bottom: size.height * 0.04,
            left: 5,
            right: 5,
            child: Column(
              children: [
                SvgPicture.asset('assets/svg/all-india.svg'),
                // Text(
                //   'ALL INDIA MAJLIS-E-\nITTEHADUL MUSLIMEEN',
                //   textAlign: TextAlign.center,
                //   style: GoogleFonts.roboto(
                //     // fontFamily: 'Courier',
                //     fontSize: 32,
                //     fontWeight: FontWeight.w900,
                //     height: 1.35,
                //     // color: Color.fromRGBO(13, 83, 55, 1),
                //     letterSpacing: 1.2,
                //     foreground: Paint()
                //       ..style = PaintingStyle.stroke
                //       ..strokeWidth = 1.0
                //       ..color = Colors.white,
                //   ),
                // ),
                SizedBox(height: size.height * 0.04),
                Text(
                  'Designed & Build in India',
                  style: GoogleFonts.roboto(
                    color: Color.fromRGBO(255, 255, 255, 0.8),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WhiteBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final path = Path();

    double topY = size.height * 0.34;
    double topCurveY = size.height * 0.42;

    double bottomY = size.height * 0.70;
    double bottomCurveY = size.height * 0.82;

    path.moveTo(0, topY);
    path.quadraticBezierTo(size.width / 2, topCurveY, size.width, topY);
    path.lineTo(size.width, bottomY);
    path.quadraticBezierTo(size.width / 2, bottomCurveY, 0, bottomY);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// ── India map outline (simplified silhouette) ─────────────────────────────────

class _IndiaMapPainter extends CustomPainter {
  const _IndiaMapPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    final path = Path();
    // Kashmir NW bump
    path.moveTo(w * 0.30, h * 0.08);
    path.lineTo(w * 0.22, h * 0.02);
    path.lineTo(w * 0.38, 0);
    // North border east
    path.lineTo(w * 0.55, h * 0.03);
    path.lineTo(w * 0.70, h * 0.07);
    path.lineTo(w * 0.85, h * 0.14);
    // Northeast
    path.lineTo(w * 0.92, h * 0.28);
    path.lineTo(w * 0.88, h * 0.42);
    // East coast
    path.lineTo(w * 0.80, h * 0.58);
    path.lineTo(w * 0.68, h * 0.74);
    path.lineTo(w * 0.55, h * 0.88);
    // Southern tip
    path.lineTo(w * 0.44, h * 0.98);
    // West coast up
    path.lineTo(w * 0.30, h * 0.85);
    path.lineTo(w * 0.15, h * 0.65);
    // Gujarat peninsula
    path.lineTo(w * 0.05, h * 0.56);
    path.lineTo(w * 0.12, h * 0.48);
    path.lineTo(w * 0.04, h * 0.42);
    // Kutch / NW coastline
    path.lineTo(w * 0.10, h * 0.32);
    path.lineTo(w * 0.06, h * 0.22);
    // Back to Kashmir
    path.lineTo(w * 0.18, h * 0.12);
    path.close();

    canvas.drawPath(path, paint);

    // Island dots (Sri Lanka + Andaman + Lakshadweep roughly)
    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    // Sri lanka
    canvas.drawCircle(Offset(w * 0.52, h * 1.04), 2, dotPaint);
    canvas.drawCircle(Offset(w * 0.50, h * 1.02), 1.5, dotPaint);
    // Andaman
    canvas.drawCircle(Offset(w * 0.88, h * 0.80), 1.5, dotPaint);
    canvas.drawCircle(Offset(w * 0.87, h * 0.85), 1.5, dotPaint);
    canvas.drawCircle(Offset(w * 0.89, h * 0.90), 1.5, dotPaint);
    // Lakshadweep
    canvas.drawCircle(Offset(w * 0.25, h * 0.90), 1.5, dotPaint);
    canvas.drawCircle(Offset(w * 0.27, h * 0.94), 1.5, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
