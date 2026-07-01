import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

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
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 90.w,
                      height: 110.h,
                      child: SvgPicture.asset('assets/svg/india-map.svg'),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.2),
                            blurRadius: 15.r,
                            spreadRadius: 1.r,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: SvgPicture.asset(
                        'assets/svg/Logo.svg',
                        width: 150.w,
                        height: 38.h,
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
                width: 150.w,
                height: 150.h,
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
            left: 16.w,
            right: 16.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Column(
                  children: [
                    Text(
                      'AIMIM',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.rubikMoonrocks(
                        fontSize: 115.sp,

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
            left: 12.w,
            right: 16.w,
            child: Text(
              'NATIONAL MEMBERSHIP PLATFORM',
              textAlign: TextAlign.center,
              style: GoogleFonts.rubikMoonrocks(
                fontSize: 19.5.sp,

                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(13, 83, 55, 1),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.56,
            left: 12.w,
            right: 16.w,
            child: Text(
              'True Democracy\n Every Citizen Matters, Beyond Identity',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 20.sp,

                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.66,
            left: 70.w,
            right: 70.w,
            child: const SpinKitChasingDots(
              color: Color.fromRGBO(13, 83, 55, 1), // Using green instead of white so it's visible on the white background
              size: 50.0,
            ),
          ),
          // 4. Bottom Green Section
          Positioned(
            bottom: size.height * 0.04,
            left: 5.w,
            right: 5.w,
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
                SizedBox(height: 0.04.sh),
                Text(
                  'Designed & Build in India',
                  style: GoogleFonts.roboto(
                    color: Color.fromRGBO(255, 255, 255, 0.8),
                    fontSize: 20.sp,
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
