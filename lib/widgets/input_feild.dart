import 'package:aimim_mobile_app/constants.dart';
import 'package:aimim_mobile_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class InputField extends StatelessWidget {
  final String labelText;
  final Function validatior;
  final void Function(String?)? saved;
  final void Function(String)? submitted;
  final void Function(String)? onChanged;
  final Function()? onTap;
  final TextEditingController inputController;
  final TextInputType? type;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool secure;
  final IconData? suffix;
  final bool readOnly;
  final Function()? suffixPress;
  final int? maxLines;
  final Color? bgColor;
  final Color? bdColor;
  final Color? iconColor;
  final Color? labelColor;
  final IconData? prefix;
  final String? errorText;
  final Function()? onSuffixTap;
  final String title;
  final String? svgTitleIcon;
  final double? titleWidth;

  const InputField({
    super.key,
    required this.labelText,
    required this.validatior,
    required this.inputController,
    this.onTap,
    this.type,
    this.focusNode,
    this.submitted,
    this.saved,
    this.suffix,
    this.maxLines = 1,
    this.suffixPress,
    this.onChanged,
    this.bgColor,
    this.bdColor,
    this.iconColor,
    this.labelColor,
    this.prefix,
    this.errorText,
    this.onSuffixTap,
    this.textInputAction,
    required this.title,
    this.svgTitleIcon,
    this.readOnly = false,
    this.secure = false,
    this.titleWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 0.h),
      // decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty)
            Row(
              children: [
                SizedBox(width: 0.w),
                if (svgTitleIcon != null)
                  Container(
                    margin: EdgeInsets.only(right: 5.w),
                    child: SvgPicture.asset(svgTitleIcon!),
                  ),
                SizedBox(
                  // width: titleWidth ?? 360.w,
                  child: Text(
                    title,
                    // maxLines: 2,
                    style: AppTheme.lightTheme.textTheme.titleMedium!.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(13, 83, 55, 1),
                    ),
                  ),
                ),
              ],
            ),
          SizedBox(height: 7.h),
          TextFormField(
            onTap: onTap,
            autocorrect: false,
            onChanged: onChanged,
            maxLines: maxLines,
            onFieldSubmitted: submitted,
            onSaved: saved,
            focusNode: focusNode,
            textInputAction: textInputAction ?? TextInputAction.next,
            obscureText: secure,
            readOnly: readOnly,
            keyboardType: type == TextInputType.number
                ? const TextInputType.numberWithOptions(decimal: true)
                : (type ?? TextInputType.text),
            controller: inputController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              var error = validatior(value);

              return error;
            },
            textAlign: TextAlign.start,
            style: AppTheme.lightTheme.textTheme.bodyLarge!.copyWith(
              fontSize: AppTheme.isIpad(context) ? 12.sp : 14.sp,
              fontWeight: FontWeight.bold,
              color: labelColor ?? AppTheme.white,
            ),
            cursorHeight: 14.h,
            cursorColor: AppTheme.white,

            // obscuringCharacter: '*',
            decoration: InputDecoration(
              suffixIcon: suffix == null
                  ? null
                  : IconButton(
                      onPressed: onSuffixTap,
                      icon: Icon(suffix, color: AppTheme.primaryPink),
                    ),
              errorText: errorText,
              prefixIcon: prefix == null
                  ? null
                  : Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: Icon(
                        prefix ?? Icons.search,
                        color: AppTheme.primaryPink,
                      ),
                    ),
              fillColor: Colors.white.withValues(alpha: 0.1),
              filled: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: AppTheme.isIpad(context)
                    ? 10.h
                    : maxLines == 1
                    ? AppTheme.isIpad(context)
                          ? 10.h
                          : 10.h
                    : 20.h,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.primaryPink, width: 0.8),
                borderRadius: BorderRadius.circular(8.r),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: AppTheme.primaryPink, width: 0.8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.primaryPink, width: 0.8),
                borderRadius: BorderRadius.circular(8.r),
              ),
              hintText: labelText,
              hintStyle: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: AppTheme.greyText,
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 0.8),
                borderRadius: BorderRadius.circular(8.r),
              ),
              errorStyle: const TextStyle(height: 0, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
