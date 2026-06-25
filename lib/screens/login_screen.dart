import 'package:aimim_mobile_app/theme/app_theme.dart';
import 'package:aimim_mobile_app/widgets/input_feild.dart';
import 'package:aimim_mobile_app/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import '../widgets/pin_input_row.dart';
import '../widgets/onboarding_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _idController = TextEditingController();
  final _pinKey = GlobalKey<PinInputRowState>();
  bool _rememberMe = false;
  bool _obscurePin = true;

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login-bg.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            // PasscContainode label
            Expanded(
              flex: 11,
              child: Container(
                margin: const EdgeInsets.only(top: 50),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    HeaderRow(),
                    SizedBox(height: 15),
                    Stack(
                      children: [
                        Text(
                          'AIMIM',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.rubikMoonrocks(
                            fontSize: 112,

                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Positioned(
                          bottom: 3,
                          left: 0,
                          child: Text(
                            'All India Majlis-E-Ittehadul Muslimeen',
                            style: GoogleFonts.roboto(
                              fontSize: 20.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 20.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Column(
                        children: [
                          InputField(
                            labelText:
                                'Enter member Id, mobile number or email',
                            validatior: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your ID';
                              }
                              return null;
                            },
                            svgTitleIcon: 'assets/svg/email.svg',
                            inputController: _idController,
                            title: 'Login with Passcode *',
                          ),
                          SizedBox(height: 8.h),
                          PinInputRow(key: _pinKey),
                          SizedBox(height: 0.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    visualDensity: VisualDensity.compact,
                                    value: _rememberMe,
                                    onChanged: (value) {
                                      setState(() {
                                        _rememberMe = value ?? false;
                                      });
                                    },
                                  ),
                                  Text(
                                    'REMEMBER ME',
                                    style: TextStyle(
                                      color: AppTheme.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  // Handle forgot passcode action
                                },
                                child: Text(
                                  'NEED HELP?',
                                  style: TextStyle(
                                    color: AppTheme.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // Add some spacing between the button and the right edge
                            ],
                          ),
                          SizedBox(height: 0.h),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.all(10.w),
                                  decoration: BoxDecoration(
                                    color: AppTheme.black,
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/svg/finger-print.svg',
                                    width: 20.w,
                                    height: 20.h,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20.w),
                              Expanded(
                                flex: 8,
                                child: SubmitButton(
                                  // width: 150.w,
                                  height: 45.h,
                                  text: 'LOGIN NOW',
                                  onTap: () {
                                    Navigator.pushNamed(context, '/home');

                                    // Handle login action
                                  },
                                  bgColor: AppTheme.primarygreen,
                                  textColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h),
                    SubmitButton(
                      text: 'LOGIN WITH WHATSAPP',
                      svgIcon: 'assets/svg/facebook.svg',
                      onTap: () {
                        // Handle login with OTP action
                      },
                      bgColor: Colors.white.withValues(alpha: 0.9),
                      borderWidth: 1.5.sp,
                      bdColor: Colors.black,
                      textColor: AppTheme.black,
                    ),
                    SizedBox(height: 10.h),
                    SubmitButton(
                      text: 'LOGIN WITH GOOGLE',
                      textColor: AppTheme.white,
                      svgIcon: 'assets/svg/google-1.svg',
                      onTap: () {
                        // Handle login with OTP action
                      },
                      bgColor: Colors.black,
                      borderWidth: 1.5.sp,
                      bdColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                child: Column(
                  children: [
                    SubmitButton(
                      text: 'CREATE A NEW ACCOUNT',
                      textColor: AppTheme.white,
                      onTap: () {
                        // Handle login with OTP action
                      },
                      bgColor: AppTheme.primarygreen,
                      borderWidth: 1.5.sp,
                      bdColor: Colors.white,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'BY CONTINUING, YOU ARE AGREEING TO OUR\nTERMS OF USE & PRIVACY POLICY.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppTheme.primarygreen,
                        fontSize: 11.sp,
                        height: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderRow extends StatelessWidget {
  const HeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset('assets/svg/india-map.svg', width: 100, height: 100),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SvgPicture.asset('assets/svg/Logo.svg', width: 100, height: 38),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                'SKIP',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
