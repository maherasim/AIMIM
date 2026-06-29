import 'package:aimim_mobile_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import '../../widgets/alert_banner.dart';
import 'membership_success_screen.dart';

class MembershipFormScreen extends StatefulWidget {
  const MembershipFormScreen({super.key});

  @override
  State<MembershipFormScreen> createState() => _MembershipFormScreenState();
}

class _MembershipFormScreenState extends State<MembershipFormScreen> {
  int _step = 0; // 0, 1, 2
  final _pageController = PageController();

  // Step 1 controllers & state
  String? _s1State;
  String? _s1District;
  final _epicController = TextEditingController();
  final _fullNameController = TextEditingController();
  String? _shortPrefix;
  final _shortNameController = TextEditingController();
  String? _gender;
  String? _dobYear;
  final _mobileController = TextEditingController();
  String? _contactType;
  final _additionalContactController = TextEditingController();
  bool _s1Agreed = false;

  // Step 2 controllers & state
  final _s2NameController = TextEditingController();
  String? _s2Gender;
  String? _s2DobYear;
  final _s2ContactController = TextEditingController();
  String? _s2State;
  String? _s2District;
  String? _s2Assembly;
  String? _membershipType;
  String? _memberActivity;
  bool _s2Agreed = false;

  static const _states = [
    'Uttar Pradesh',
    'Maharashtra',
    'Bihar',
    'Telangana',
    'Karnataka',
    'Tamil Nadu',
    'West Bengal',
    'Rajasthan',
    'Gujarat',
    'Madhya Pradesh',
    'Andhra Pradesh',
    'Odisha',
    'Jharkhand',
    'Assam',
    'Punjab',
  ];
  static const _districts = [
    'Hyderabad',
    'Lucknow',
    'Mumbai',
    'Patna',
    'Aurangabad',
    'Sant Kabir Nagar',
    'Dhanghata',
    'Gorakhpur',
    'Varanasi',
    'Agra',
  ];
  static const _assemblies = [
    'AC 314 Dhanghata',
    'AC 001 Hyderabad Central',
    'AC 045 Aurangabad East',
    'AC 012 Lucknow Central',
    'AC 078 Mumbai South',
    'AC 023 Patna Sahib',
  ];
  static const _membershipTypes = [
    'Primary Member',
    'Active Member',
    'Life Member',
    'Youth Wing Member',
    'Women Wing Member',
    'Student Wing Member',
  ];
  static const _activities = [
    'Social Work',
    'Political Campaign',
    'Voter Registration Drive',
    'Community Service',
    'Party Administration',
    'Fundraising',
    'Media & Communication',
    'Legal Aid',
  ];
  static const _shortPrefixes = ['Mr.', 'Mrs.', 'Ms.', 'Dr.', 'Er.'];
  static const _contactTypes = ['WhatsApp', 'Email', 'Phone', 'Telegram'];
  static const _years = [
    '2006',
    '2005',
    '2004',
    '2000',
    '1995',
    '1990',
    '1985',
    '1980',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _epicController.dispose();
    _fullNameController.dispose();
    _shortNameController.dispose();
    _mobileController.dispose();
    _additionalContactController.dispose();
    _s2NameController.dispose();
    _s2ContactController.dispose();
    super.dispose();
  }

  void _goNext() {
    if (_step < 2) {
      setState(() => _step++);
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goBack() {
    if (_step > 0) {
      setState(() => _step--);
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryGreen,
      appBar: AppBar(
        backgroundColor: kPrimaryGreen,
        elevation: 0,
        leadingWidth: 50,
        leading: GestureDetector(
          onTap: _goBack,
          child: Container(
            padding: EdgeInsets.only(left: 20),
            // margin: EdgeInsets.only(right: 0),
            child: Bounceable(
              onTap: () {},
              child: SvgPicture.asset(
                'assets/svg/arrow_back.svg',
                height: 30.sp,
              ),
            ),
          ),
        ),
        //  IconButton(
        //   icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
        //   onPressed: _goBack,
        // ),
        title: SvgPicture.asset(
          'assets/svg/Logo.svg',
          height: 50.h,
          errorBuilder: (c, e, s) => const Text(
            'AIMIM',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              letterSpacing: 3,
            ),
          ),
        ),
        centerTitle: false,
        actions: [
          _HelpButton(),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const AlertBanner(),
          // _StepIndicator(current: _step),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _Step1(
                  states: _states,
                  districts: _districts,
                  selectedState: _s1State,
                  selectedDistrict: _s1District,
                  epicController: _epicController,
                  fullNameController: _fullNameController,
                  shortPrefix: _shortPrefix,
                  shortPrefixes: _shortPrefixes,
                  shortNameController: _shortNameController,
                  gender: _gender,
                  dobYear: _dobYear,
                  years: _years,
                  mobileController: _mobileController,
                  contactType: _contactType,
                  contactTypes: _contactTypes,
                  additionalContactController: _additionalContactController,
                  agreed: _s1Agreed,
                  onStateChanged: (v) => setState(() => _s1State = v),
                  onDistrictChanged: (v) => setState(() => _s1District = v),
                  onPrefixChanged: (v) => setState(() => _shortPrefix = v),
                  onGenderChanged: (v) => setState(() => _gender = v),
                  onYearChanged: (v) => setState(() => _dobYear = v),
                  onContactTypeChanged: (v) => setState(() => _contactType = v),
                  onAgreedChanged: (v) =>
                      setState(() => _s1Agreed = v ?? false),
                  onReset: () => setState(() {
                    _s1State = null;
                    _s1District = null;
                    _epicController.clear();
                    _fullNameController.clear();
                    _shortPrefix = null;
                    _shortNameController.clear();
                    _gender = null;
                    _dobYear = null;
                    _mobileController.clear();
                    _contactType = null;
                    _additionalContactController.clear();
                    _s1Agreed = false;
                  }),
                  onNext: _goNext,
                ),
                _Step2(
                  assemblies: _assemblies,
                  districts: _districts,
                  states: _states,
                  membershipTypes: _membershipTypes,
                  activities: _activities,
                  years: _years,
                  nameController: _s2NameController,
                  gender: _s2Gender,
                  dobYear: _s2DobYear,
                  contactController: _s2ContactController,
                  selectedState: _s2State,
                  selectedDistrict: _s2District,
                  selectedAssembly: _s2Assembly,
                  membershipType: _membershipType,
                  memberActivity: _memberActivity,
                  agreed: _s2Agreed,
                  onGenderChanged: (v) => setState(() => _s2Gender = v),
                  onYearChanged: (v) => setState(() => _s2DobYear = v),
                  onStateChanged: (v) => setState(() => _s2State = v),
                  onDistrictChanged: (v) => setState(() => _s2District = v),
                  onAssemblyChanged: (v) => setState(() => _s2Assembly = v),
                  onMembershipTypeChanged: (v) =>
                      setState(() => _membershipType = v),
                  onActivityChanged: (v) => setState(() => _memberActivity = v),
                  onAgreedChanged: (v) =>
                      setState(() => _s2Agreed = v ?? false),
                  onBack: _goBack,
                  onNext: _goNext,
                  isFinalStep: false,
                ),
                _Step2(
                  assemblies: _assemblies,
                  districts: _districts,
                  states: _states,
                  membershipTypes: _membershipTypes,
                  activities: _activities,
                  years: _years,
                  nameController: _s2NameController,
                  gender: _s2Gender,
                  dobYear: _s2DobYear,
                  contactController: _s2ContactController,
                  selectedState: _s2State,
                  selectedDistrict: _s2District,
                  selectedAssembly: _s2Assembly,
                  membershipType: _membershipType,
                  memberActivity: _memberActivity,
                  agreed: _s2Agreed,
                  onGenderChanged: (v) => setState(() => _s2Gender = v),
                  onYearChanged: (v) => setState(() => _s2DobYear = v),
                  onStateChanged: (v) => setState(() => _s2State = v),
                  onDistrictChanged: (v) => setState(() => _s2District = v),
                  onAssemblyChanged: (v) => setState(() => _s2Assembly = v),
                  onMembershipTypeChanged: (v) =>
                      setState(() => _membershipType = v),
                  onActivityChanged: (v) => setState(() => _memberActivity = v),
                  onAgreedChanged: (v) =>
                      setState(() => _s2Agreed = v ?? false),
                  onBack: _goBack,
                  onNext: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MembershipSuccessScreen(
                        name: _s2NameController.text.isEmpty
                            ? _fullNameController.text
                            : _s2NameController.text,
                        enrollmentNo: '302-123456',
                        state: _s2State ?? _s1State ?? 'Uttar Pradesh',
                        district:
                            _s2District ?? _s1District ?? 'Sant Kabir Nagar',
                        assembly: _s2Assembly ?? 'AC 314 Dhanghata',
                        membershipType: _membershipType ?? 'Primary Member',
                      ),
                    ),
                  ),
                  isFinalStep: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Step indicator ──────────────────────────────────────────────────────────

class _StepIndicator extends StatelessWidget {
  final int current;
  const _StepIndicator({required this.current});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _StepCircle(n: 1, active: current >= 0, done: current > 0),
          _StepLine(active: current > 0),
          _StepCircle(n: 2, active: current >= 1, done: current > 1),
          _StepLine(active: current > 1),
          _StepCircle(n: 3, active: current >= 2, done: false),
        ],
      ),
    );
  }
}

class _StepCircle extends StatelessWidget {
  final int n;
  final bool active;
  final bool done;
  const _StepCircle({
    required this.n,
    required this.active,
    required this.done,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 30.w,
          height: 30.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? kPrimaryGreen : Colors.grey.shade200,
            border: Border.all(
              color: active ? kPrimaryGreen : Colors.grey.shade400,
              width: 1.5.w,
            ),
          ),
          child: Center(
            child: done
                ? Icon(Icons.check, color: Colors.white, size: 16.sp)
                : Text(
                    '$n',
                    style: TextStyle(
                      color: active ? Colors.white : Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                    ),
                  ),
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          n == 1
              ? 'Enrollment'
              : n == 2
              ? 'Details'
              : 'Review',
          style: TextStyle(
            fontSize: 9.sp,
            color: active ? kPrimaryGreen : Colors.grey,
            fontWeight: active ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class _StepLine extends StatelessWidget {
  final bool active;
  const _StepLine({required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.w,
      height: 2.h,
      margin: EdgeInsets.only(bottom: 14.h),
      color: active ? kPrimaryGreen : Colors.grey.shade300,
    );
  }
}

// ── Help button ─────────────────────────────────────────────────────────────

class _HelpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 4.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFF25D366),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Text(
            'Help?',
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(width: 4.w),
          SvgPicture.asset(
            'assets/svg/whatsapp-1.svg',
            color: Colors.white,
            height: 25.sp,
          ),
        ],
      ),
    );
  }
}

// ── Step 1: Enrollment ──────────────────────────────────────────────────────

class _Step1 extends StatelessWidget {
  final List<String> states, districts, shortPrefixes, contactTypes, years;
  final String? selectedState,
      selectedDistrict,
      shortPrefix,
      gender,
      dobYear,
      contactType;
  final TextEditingController epicController,
      fullNameController,
      shortNameController,
      mobileController,
      additionalContactController;
  final bool agreed;
  final ValueChanged<String?> onStateChanged,
      onDistrictChanged,
      onPrefixChanged,
      onGenderChanged,
      onYearChanged,
      onContactTypeChanged;
  final ValueChanged<bool?> onAgreedChanged;
  final VoidCallback onReset, onNext;

  const _Step1({
    required this.states,
    required this.districts,
    required this.shortPrefixes,
    required this.contactTypes,
    required this.years,
    required this.selectedState,
    required this.selectedDistrict,
    required this.shortPrefix,
    required this.gender,
    required this.dobYear,
    required this.contactType,
    required this.epicController,
    required this.fullNameController,
    required this.shortNameController,
    required this.mobileController,
    required this.additionalContactController,
    required this.agreed,
    required this.onStateChanged,
    required this.onDistrictChanged,
    required this.onPrefixChanged,
    required this.onGenderChanged,
    required this.onYearChanged,
    required this.onContactTypeChanged,
    required this.onAgreedChanged,
    required this.onReset,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 14.w, right: 14.w, bottom: 14.h, top: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Color.fromRGBO(26, 35, 126, 1),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15.r),
            ),

            child: Column(
              //upper
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Center(
                  child: Text(
                    'MEMBER APPLICATION FORM',
                    style: GoogleFonts.rubik(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryGreen,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      'Login id:  p.m.ajjukhan@gmail.com',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                _FieldLabel('State Name', required: true),
                _DropdownField(
                  hint: 'Select Your Residence State',
                  value: selectedState,
                  items: states,
                  onChanged: onStateChanged,
                ),
                SizedBox(height: 10.h),

                _FieldLabel('District Name', required: true),
                _DropdownField(
                  hint: 'Select Your Residence District',
                  value: selectedDistrict,
                  items: districts,
                  onChanged: onDistrictChanged,
                ),
                SizedBox(height: 10.h),

                _FieldLabel('EPIC · Voter Id Number', optional: true),
                Row(
                  children: [
                    SizedBox(
                      width: 130.w,
                      child: _DropdownField(
                        hint: 'Select State',
                        value: selectedState,
                        items: states,
                        onChanged: onStateChanged,
                        isFeildAttached: true,
                        bgColor: AppTheme.primaryGreen.withValues(alpha: 0.2),
                      ),
                    ),
                    // SizedBox(width: 8.w),
                    Expanded(
                      child: _InputField(
                        controller: epicController,
                        isFeildAttached: true,
                        hint: 'EPIC/Voter Card Number',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
              ],
            ),
          ),

          // Enrollment number pill

          // SizedBox(height: 14.h),
          Stack(
            clipBehavior: Clip.none,
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                padding: EdgeInsets.all(20.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color.fromRGBO(26, 35, 126, 1),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Column(
                  //lower box
                  children: [
                    _FieldLabel('Member Full Name', required: true),
                    _InputField(
                      controller: fullNameController,
                      hint: 'Enter Full Name as per Documents',
                    ),
                    SizedBox(height: 10.h),

                    _FieldLabelWithInfo('Member Short Name', required: true),
                    Row(
                      children: [
                        SizedBox(
                          width: 90,
                          child: _DropdownField(
                            hint: 'Select',
                            value: shortPrefix,
                            items: shortPrefixes,
                            onChanged: onPrefixChanged,
                            isFeildAttached: true,
                            bgColor: AppTheme.primaryGreen.withValues(
                              alpha: 0.2,
                            ),
                          ),
                        ),
                        // SizedBox(width: 8.w),
                        Expanded(
                          child: _InputField(
                            isFeildAttached: true,
                            controller: shortNameController,
                            hint: 'Enter Short or Nick name',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _FieldLabel('Gender', required: true),
                              _DropdownField(
                                hint: 'Select Gender',
                                value: gender,
                                items: const ['Male', 'Female', 'Other'],
                                onChanged: onGenderChanged,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _FieldLabelWithInfo(
                                'Age',
                                required: true,
                                note: '(18+ Only)',
                              ),
                              _DropdownField(
                                hint: 'Select DOB Year',
                                value: dobYear,
                                items: years,
                                onChanged: onYearChanged,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),

                    _FieldLabel('Mobile Number', optional: true),
                    Row(
                      children: [
                        Container(
                          height: 40.h,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            // vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppTheme.primaryGreen),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.zero,
                              bottomRight: Radius.zero,
                              topLeft: Radius.circular(5.r),
                              bottomLeft: Radius.circular(5.r),
                            ),
                            color: AppTheme.primaryGreen.withValues(alpha: 0.2),
                          ),
                          child: Center(
                            child: Text(
                              'IN  +91',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(width: 8.w),
                        Expanded(
                          child: _InputField(
                            controller: mobileController,
                            hint: 'Enter Mobile Number',
                            isFeildAttached: true,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),

                    _FieldLabelWithInfo('Additional Contact', optional: true),
                    Row(
                      children: [
                        SizedBox(
                          width: 130.w,
                          child: _DropdownField(
                            isFeildAttached: true,
                            bgColor: AppTheme.primaryGreen.withValues(
                              alpha: 0.2,
                            ),
                            hint: 'Select Type',
                            value: contactType,
                            items: contactTypes,
                            onChanged: onContactTypeChanged,
                          ),
                        ),
                        // SizedBox(width: 8.w),
                        Expanded(
                          child: _InputField(
                            isFeildAttached: true,
                            controller: additionalContactController,
                            hint: 'Enter Mobile or Email',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14.h),

                    _TermsRow(agreed: agreed, onChanged: onAgreedChanged),
                  ],
                ),
              ),
              Positioned(top: -18, child: EnrollWidget()),
            ],
          ),
          SizedBox(height: 16.h),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onReset,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black87,
                    side: const BorderSide(color: Colors.black26),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                  child: const Text(
                    'RESET',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: agreed ? onNext : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kDarkGreen,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                  child: const Text(
                    'NEXT & PREVIEW',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

class EnrollWidget extends StatelessWidget {
  const EnrollWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: Color.fromRGBO(26, 35, 126, 1), width: 2.w),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'ENROLLMENT NO. ',
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
            Text(
              '302-123456',
              style: TextStyle(
                color: Color.fromRGBO(26, 35, 126, 1),
                fontWeight: FontWeight.w900,
                fontSize: 14.sp,
                letterSpacing: 1.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Step 2 / Step 3 (shared layout, different bottom button) ────────────────

class _Step2 extends StatelessWidget {
  final List<String> states,
      districts,
      assemblies,
      membershipTypes,
      activities,
      years;
  final TextEditingController nameController, contactController;
  final String? gender,
      dobYear,
      selectedState,
      selectedDistrict,
      selectedAssembly,
      membershipType,
      memberActivity;
  final bool agreed;
  final bool isFinalStep;
  final ValueChanged<String?> onGenderChanged,
      onYearChanged,
      onStateChanged,
      onDistrictChanged,
      onAssemblyChanged,
      onMembershipTypeChanged,
      onActivityChanged;
  final ValueChanged<bool?> onAgreedChanged;
  final VoidCallback onBack, onNext;

  const _Step2({
    required this.states,
    required this.districts,
    required this.assemblies,
    required this.membershipTypes,
    required this.activities,
    required this.years,
    required this.nameController,
    required this.contactController,
    required this.gender,
    required this.dobYear,
    required this.selectedState,
    required this.selectedDistrict,
    required this.selectedAssembly,
    required this.membershipType,
    required this.memberActivity,
    required this.agreed,
    required this.isFinalStep,
    required this.onGenderChanged,
    required this.onYearChanged,
    required this.onStateChanged,
    required this.onDistrictChanged,
    required this.onAssemblyChanged,
    required this.onMembershipTypeChanged,
    required this.onActivityChanged,
    required this.onAgreedChanged,
    required this.onBack,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(14),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade200),
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card header
            Row(
              children: [
                const Text(
                  'AIMIM Member Enrollment: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                Text(
                  '302-123456',
                  style: const TextStyle(
                    color: kPrimaryGreen,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 11, color: Colors.grey),
                children: [
                  TextSpan(text: 'Login ID: '),
                  TextSpan(
                    text: '*',
                    style: TextStyle(color: Colors.red),
                  ),
                  TextSpan(text: '  p.m.ajjukhan@gmail.com'),
                ],
              ),
            ),
            const Divider(height: 16),

            _FieldLabel('Member Name', required: true),
            _InputField(controller: nameController, hint: 'Enter Member Name'),
            SizedBox(height: 10.h),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FieldLabel('Gender', required: true),
                      _DropdownField(
                        hint: 'Select Gender',
                        value: gender,
                        items: const ['Male', 'Female', 'Other'],
                        onChanged: onGenderChanged,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FieldLabelWithInfo('Age', required: true),
                      _DropdownField(
                        hint: 'Select DOB Year',
                        value: dobYear,
                        items: years,
                        onChanged: onYearChanged,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),

            _FieldLabelWithInfo('Mobile or E-mail Address', optional: true),
            _InputField(
              controller: contactController,
              hint: 'Enter Mobile Number or E-mail',
            ),
            SizedBox(height: 10.h),

            _FieldLabelWithInfo('State Name', required: true),
            _DropdownField(
              hint: 'Select Your Residence State',
              value: selectedState,
              items: states,
              onChanged: onStateChanged,
            ),
            SizedBox(height: 10.h),

            _FieldLabel('District Name', required: true),
            _DropdownField(
              hint: 'Select Your Residence District',
              value: selectedDistrict,
              items: districts,
              onChanged: onDistrictChanged,
            ),
            SizedBox(height: 10.h),

            _FieldLabel('Assembly · Vidhan Sabha', required: true),
            _DropdownField(
              hint: 'Select AC · Assembly Constituency',
              value: selectedAssembly,
              items: assemblies,
              onChanged: onAssemblyChanged,
            ),
            SizedBox(height: 10.h),

            _FieldLabelWithInfo('Membership Type', required: true),
            _DropdownField(
              hint: 'Select Membership Programe',
              value: membershipType,
              items: membershipTypes,
              onChanged: onMembershipTypeChanged,
            ),
            SizedBox(height: 10.h),

            _FieldLabelWithInfo('Member Activity', required: true),
            _DropdownField(
              hint: 'Select Your Activity in AIMIM Party',
              value: memberActivity,
              items: activities,
              onChanged: onActivityChanged,
            ),
            SizedBox(height: 14.h),

            _TermsRow(agreed: agreed, onChanged: onAgreedChanged),
            SizedBox(height: 16.h),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onBack,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      side: const BorderSide(color: Colors.black26),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: const Text(
                      'BACK',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: agreed ? onNext : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kDarkGreen,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: Text(
                      isFinalStep ? 'FINAL SUBMIT' : 'NEXT',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}

// ── Shared small widgets ────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  final String text;
  final bool required;
  final bool optional;
  const _FieldLabel(this.text, {this.required = false, this.optional = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            text,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w700,
              fontSize: 14.sp,
              color: AppTheme.primaryGreen,
            ),
          ),
          if (required)
            const Text(
              ' *',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          if (optional)
            const Text(
              '  (OPTIONAL)',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 10,
                fontWeight: FontWeight.normal,
              ),
            ),
        ],
      ),
    );
  }
}

class _FieldLabelWithInfo extends StatelessWidget {
  final String text;
  final bool required;
  final bool optional;
  final String? note;
  const _FieldLabelWithInfo(
    this.text, {
    this.required = false,
    this.optional = false,
    this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: kDarkGreen,
            ),
          ),
          if (required)
            const Text(
              ' *',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          if (optional)
            Text(
              '  (OPTIONAL)',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 10.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          if (note != null)
            Text(
              '  $note',
              style: TextStyle(color: Colors.grey, fontSize: 10.sp),
            ),
          SizedBox(width: 4.w),
          Icon(Icons.info_outline, size: 13.sp, color: Colors.grey),
        ],
      ),
    );
  }
}

class _DropdownField extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> items;
  final Color bgColor;
  final bool isFeildAttached;
  final ValueChanged<String?> onChanged;
  const _DropdownField({
    required this.hint,
    required this.value,
    required this.items,
    this.bgColor = Colors.white,
    this.isFeildAttached = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
          top: BorderSide(color: AppTheme.primaryGreen, width: 1),
          left: BorderSide(color: AppTheme.primaryGreen, width: 1),
          bottom: BorderSide(color: AppTheme.primaryGreen, width: 1),
          right: isFeildAttached
              ? BorderSide.none
              : BorderSide(color: AppTheme.primaryGreen, width: 1),
          // Omit 'bottom' to leave it borderless
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.r),
          topRight: isFeildAttached ? Radius.zero : Radius.circular(5.r),
          bottomLeft: Radius.circular(5.r),
          bottomRight: isFeildAttached ? Radius.zero : Radius.circular(5.r),
        ),
      ),
      height: 40.h,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          padding: EdgeInsets.zero,
          value: value,
          hint: Text(
            hint,
            style: GoogleFonts.roboto(
              color: Color.fromRGBO(13, 83, 55, 0.5),
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: AppTheme.primaryGreen),
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: TextStyle(fontSize: 13.sp),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final bool isFeildAttached;
  const _InputField({
    required this.controller,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.inputFormatters = const [],
    this.isFeildAttached = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        style: TextStyle(fontSize: 13.sp),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.roboto(
            color: Color.fromRGBO(13, 83, 55, 0.5),
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: AppTheme.primaryGreen),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.r),
              bottomRight: Radius.circular(8.r),
              topLeft: isFeildAttached ? Radius.zero : Radius.circular(8.r),
              bottomLeft: isFeildAttached ? Radius.zero : Radius.circular(8.r),
            ),
            borderSide: BorderSide(color: AppTheme.primaryGreen),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.r),
              bottomRight: Radius.circular(8.r),
              topLeft: isFeildAttached ? Radius.zero : Radius.circular(8.r),
              bottomLeft: isFeildAttached ? Radius.zero : Radius.circular(8.r),
            ),
            borderSide: BorderSide(color: AppTheme.primaryGreen, width: 1.5.w),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}

class _TermsRow extends StatelessWidget {
  final bool agreed;
  final ValueChanged<bool?> onChanged;
  const _TermsRow({required this.agreed, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: agreed,
          onChanged: onChanged,
          activeColor: kPrimaryGreen,
          side: const BorderSide(color: kPrimaryGreen, width: 1.5),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
        SizedBox(width: 4.w),
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 12.sp, color: Colors.black87),
            children: [
              const TextSpan(text: 'I AGREE '),
              TextSpan(
                text: 'TERMS',
                style: TextStyle(
                  color: kPrimaryGreen,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              const TextSpan(text: ' & '),
              TextSpan(
                text: 'CONDITIONS.',
                style: const TextStyle(
                  color: kPrimaryGreen,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
