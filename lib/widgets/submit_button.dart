import 'package:aimim_mobile_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class SubmitButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Color? bgColor;
  final Color? bdColor;
  final double? borderWidth;
  final Color? textColor;
  final bool? isShadow;
  final IconData? icon;
  final Color? iconColor;
  final double? textSize;
  final double? iconSize;
  final double? height;
  final String? svgIcon;

  const SubmitButton({
    super.key,
    this.onTap,
    required this.text,
    this.bgColor,
    this.bdColor,
    this.borderWidth,
    this.textColor,
    this.icon,
    this.isShadow = false,
    this.iconColor,
    this.height,
    this.iconSize,
    this.textSize,
    this.svgIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      duration: const Duration(milliseconds: 300),
      onTap: onTap ?? () {},
      // duration: const Duration(milliseconds: 300),
      child: Container(
        height: AppTheme.isIpad(context) ? 60.h : height ?? 50.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: bgColor ?? AppTheme.primaryPink.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(25.r),
          border: Border.all(
            color: bdColor ?? Colors.transparent,
            width: borderWidth ?? 0,
          ),
          boxShadow: isShadow!
              ? const [
                  BoxShadow(
                    color: Color.fromRGBO(
                      0,
                      0,
                      0,
                      0.08,
                    ), // RGBA color with 0.08 opacity
                    blurRadius: 26.17174, // Blur radius
                    offset: Offset(0, 0), // Offset for X and Y axis
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (svgIcon != null)
                Container(
                  margin: EdgeInsets.only(right: 10.w),
                  child: SvgPicture.asset(svgIcon!, height: 20.h, width: 20.w),
                ),
              if (icon != null)
                Container(
                  margin: EdgeInsets.only(right: 8.w),
                  child: Icon(
                    icon,
                    size: iconSize ?? 18.sp,
                    color: iconColor ?? Colors.red,
                  ),
                ),
              Text(
                text,
                textScaler: MediaQuery.of(context).textScaler,
                style: AppTheme.lightTheme.textTheme.labelMedium!.copyWith(
                  color:
                      textColor ??
                      (bgColor != null ? Colors.black : Colors.white),
                  fontSize: AppTheme.isIpad(context)
                      ? 12.sp
                      : textSize ?? 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    //  SizedBox(
    //   width: double.infinity,
    //   height: 62.h,
    //   child:

    //    TextButton(
    //       style: TextButton.styleFrom(
    //         backgroundColor: Colors.black,
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(70.r),
    //         ),
    //       ),
    //       onPressed: onTap,
    //       child: Text(
    //         text,
    //         style:  TextStyle(
    //           color: Colors.white,
    //           fontSize: 16.sp,
    //           fontWeight: FontWeight.w500,
    //         ),
    //       )),
    // );
  }
}

class BounceAnimationWrapper extends StatefulWidget {
  final Widget child;

  const BounceAnimationWrapper({super.key, required this.child});

  @override
  // ignore: library_private_types_in_public_api
  _BounceAnimationWrapperState createState() => _BounceAnimationWrapperState();
}

class _BounceAnimationWrapperState extends State<BounceAnimationWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        _controller.forward();
      },
      onTapUp: (details) {
        _controller.reverse();
      },
      onTapCancel: () {
        _controller.reverse();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(scale: _animation.value, child: widget.child);
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
