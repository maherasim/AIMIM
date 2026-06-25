import 'package:aimim_mobile_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../constants.dart';

class PinInputRow extends StatefulWidget {
  final bool obscure;
  final ValueChanged<String>? onCompleted;

  const PinInputRow({super.key, this.obscure = true, this.onCompleted});

  @override
  State<PinInputRow> createState() => PinInputRowState();
}

class PinInputRowState extends State<PinInputRow> {
  final _controllers = List.generate(6, (_) => TextEditingController());
  final _focusNodes = List.generate(6, (_) => FocusNode());

  String get pin => _controllers.map((c) => c.text).join();

  void clear() {
    for (final c in _controllers) {
      c.clear();
    }
    if (mounted) _focusNodes[0].requestFocus();
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 5.w),
              child: SvgPicture.asset('assets/svg/lock.svg'),
            ),
            Text(
              'Passcode *',
              // maxLines: 2,
              style: AppTheme.lightTheme.textTheme.titleMedium!.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(13, 83, 55, 1),
              ),
            ),
          ],
        ),
        SizedBox(height: 7.h),

        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...List.generate(6, _buildBox),
            Container(
              height: 40,
              width: 48.5.w,
              decoration: BoxDecoration(
                color: AppTheme.primarygreen,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.r),
                  bottomRight: Radius.circular(8.r),
                ),
              ),
              child: Center(child: Icon(Icons.visibility, color: Colors.white)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBox(int i) {
    return SizedBox(
      width: 48.5.w,
      height: 40,
      child: TextField(
        controller: _controllers[i],
        focusNode: _focusNodes[i],
        maxLength: 1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        obscureText: widget.obscure,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(i == 0 ? 8.r : 0),
              bottomLeft: Radius.circular(i == 0 ? 8.r : 0),
            ),
            borderSide: BorderSide(color: AppTheme.primarygreen),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(i == 0 ? 8.r : 0),
              bottomLeft: Radius.circular(i == 0 ? 8.r : 0),
            ),
            borderSide: const BorderSide(
              color: AppTheme.primarygreen,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (val) {
          if (val.length == 1 && i < 5) {
            _focusNodes[i + 1].requestFocus();
          } else if (val.isEmpty && i > 0) {
            _focusNodes[i - 1].requestFocus();
          }
          final current = pin;
          if (current.length == 6) widget.onCompleted?.call(current);
        },
      ),
    );
  }
}
