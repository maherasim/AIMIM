import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static const Color primaryGreen = Color(0xFF0D5337);
  static const Color primaryPink = primaryGreen;
  static const Color primarygreen = primaryGreen;

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey50 = Color(0xFFF8FAFC);
  static const Color greyText = Color(0xFF898989);

  static const Color scaffoldBackground = Color(0xFFF7F7F7);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardBorder = primaryGreen;
  static const Color textPrimary = black;
  static const Color textSecondary = greyText;
  static const Color textAccent = primaryGreen;

  static const List<Color> backgroundGradient = [
    primaryGreen,
    Color(0xFF0B3F2A),
  ];

  static bool isIpad(BuildContext context) {
    return MediaQuery.of(context).size.width > 600;
  }

  static double ipadAwareSp(
    BuildContext context, {
    required double mobileSpValue,
    required double ipadSpValue,
  }) {
    return (isIpad(context) ? ipadSpValue : mobileSpValue).sp;
  }

  static TextStyle quoteScriptTextStyle(
    BuildContext context, {
    required Color color,
    required bool isLarge,
  }) {
    final fontSize = ipadAwareSp(
      context,
      ipadSpValue: 14,
      mobileSpValue: isLarge ? 17.26 : 16,
    );
    return GoogleFonts.pinyonScript(
      fontSize: fontSize,
      color: color,
      height: 1.22,
    );
  }

  static TextStyle quoteMontserratTextStyle(
    BuildContext context, {
    required Color color,
    required bool isLarge,
  }) {
    final fontSize = ipadAwareSp(
      context,
      ipadSpValue: 14,
      mobileSpValue: isLarge ? 17.26 : 16,
    );
    return GoogleFonts.montserrat(
      fontSize: fontSize,
      fontWeight: FontWeight.w800,
      color: color,
      height: 1.22,
    );
  }

  static TextStyle dailyTrackerHeadlineSmallStyle(BuildContext context) {
    return GoogleFonts.inter(
      color: textAccent,
      fontSize: ipadAwareSp(context, mobileSpValue: 16, ipadSpValue: 14),
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle brandTitleStyle(BuildContext context, {Color? color}) {
    return GoogleFonts.rubikMoonrocks(
      color: color ?? white,
      fontSize: 112.sp,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle authSubtitleStyle(BuildContext context, {Color? color}) {
    return GoogleFonts.roboto(
      color: color ?? white,
      fontSize: 20.5.sp,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle fontFamilyPrimary({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color,
    );
  }

  static TextStyle fontFamilyBold({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
  }) {
    return GoogleFonts.montserrat(
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.bold,
      color: color,
    );
  }

  static TextStyle fontFamilyScript({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
  }) {
    return GoogleFonts.pinyonScript(
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color,
    );
  }

  static TextStyle fontFamilyTime({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color,
    );
  }

  static const MaterialColor primarySwatch =
      MaterialColor(0xFF0D5337, <int, Color>{
        50: Color(0xFFE8F3EE),
        100: Color(0xFFCFE8DB),
        200: Color(0xFFB6DCC8),
        300: Color(0xFF9DD0B6),
        400: Color(0xFF7FC59F),
        500: Color(0xFF0D5337),
        600: Color(0xFF0A452D),
        700: Color(0xFF083A25),
        800: Color(0xFF062D1D),
        900: Color(0xFF042015),
      });

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primarySwatch: primarySwatch,
      primaryColor: primaryGreen,
      scaffoldBackgroundColor: scaffoldBackground,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGreen,
        brightness: Brightness.light,
      ),
      fontFamily: GoogleFonts.inter().fontFamily,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: primaryGreen),
        titleTextStyle: GoogleFonts.inter(
          color: primaryGreen,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.montserrat(
          color: textPrimary,
          fontSize: 32.sp,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: GoogleFonts.montserrat(
          color: textPrimary,
          fontSize: 28.sp,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: GoogleFonts.montserrat(
          color: textPrimary,
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
        ),
        headlineLarge: GoogleFonts.montserrat(
          color: textAccent,
          fontSize: 22.sp,
          fontWeight: FontWeight.w800,
        ),
        headlineMedium: GoogleFonts.inter(
          color: textPrimary,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: GoogleFonts.inter(
          color: textPrimary,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: GoogleFonts.inter(
          color: textPrimary,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: GoogleFonts.inter(
          color: textPrimary,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: GoogleFonts.inter(
          color: textSecondary,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: GoogleFonts.inter(
          color: textPrimary,
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: GoogleFonts.inter(
          color: textPrimary,
          fontSize: 14.sp,
          fontWeight: FontWeight.normal,
        ),
        bodySmall: GoogleFonts.inter(
          color: textSecondary,
          fontSize: 12.sp,
          fontWeight: FontWeight.normal,
        ),
        labelLarge: GoogleFonts.inter(
          color: textPrimary,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        labelMedium: GoogleFonts.inter(
          color: textPrimary,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: GoogleFonts.inter(
          color: textSecondary,
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      iconTheme: IconThemeData(color: primaryGreen, size: 24.sp),
      cardTheme: CardThemeData(
        color: cardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(color: cardBorder, width: 0.5.w),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: white,
        selectedItemColor: primaryGreen,
        unselectedItemColor: black,
        selectedIconTheme: IconThemeData(color: primaryGreen),
        unselectedIconTheme: IconThemeData(color: black),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: cardBorder, width: 0.5.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: cardBorder, width: 0.5.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: primaryGreen, width: 1.w),
        ),
        labelStyle: GoogleFonts.inter(color: textPrimary, fontSize: 14.sp),
        hintStyle: GoogleFonts.inter(color: textSecondary, fontSize: 14.sp),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          textStyle: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryGreen,
          side: BorderSide(color: cardBorder, width: 0.5.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          textStyle: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          textStyle: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFFE5E7EB),
        thickness: 1,
        space: 1,
      ),
    );
  }

  static ThemeData get darkTheme {
    final base = lightTheme;
    return base.copyWith(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0C0C0C),
      cardTheme: base.cardTheme.copyWith(
        color: const Color(0xFF151515),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(color: primaryGreen, width: 0.5.w),
        ),
      ),
      appBarTheme: base.appBarTheme.copyWith(
        iconTheme: const IconThemeData(color: white),
        titleTextStyle: GoogleFonts.inter(
          color: white,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: base.textTheme.apply(bodyColor: white, displayColor: white),
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        fillColor: const Color(0xFF171717),
        labelStyle: GoogleFonts.inter(color: white, fontSize: 14.sp),
        hintStyle: GoogleFonts.inter(color: greyText, fontSize: 14.sp),
      ),
    );
  }

  static BoxDecoration get gradientDecoration {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: backgroundGradient,
      ),
    );
  }

  static BoxDecoration get cardDecoration {
    return BoxDecoration(
      color: cardBackground,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: cardBorder, width: 0.5.w),
      boxShadow: [
        BoxShadow(
          color: primaryGreen.withOpacity(0.18),
          blurRadius: 5.4.r,
          spreadRadius: 0,
        ),
      ],
    );
  }

  static BoxDecoration get cardDecorationWithShadow {
    return BoxDecoration(
      border: Border.all(
        color: primaryGreen,
        width: 0.3.w,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      borderRadius: BorderRadius.circular(12.r),
      color: cardBackground,
    );
  }
}
