import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    'Uttar Pradesh', 'Maharashtra', 'Bihar', 'Telangana', 'Karnataka',
    'Tamil Nadu', 'West Bengal', 'Rajasthan', 'Gujarat', 'Madhya Pradesh',
    'Andhra Pradesh', 'Odisha', 'Jharkhand', 'Assam', 'Punjab',
  ];
  static const _districts = [
    'Hyderabad', 'Lucknow', 'Mumbai', 'Patna', 'Aurangabad',
    'Sant Kabir Nagar', 'Dhanghata', 'Gorakhpur', 'Varanasi', 'Agra',
  ];
  static const _assemblies = [
    'AC 314 Dhanghata', 'AC 001 Hyderabad Central', 'AC 045 Aurangabad East',
    'AC 012 Lucknow Central', 'AC 078 Mumbai South', 'AC 023 Patna Sahib',
  ];
  static const _membershipTypes = [
    'Primary Member', 'Active Member', 'Life Member', 'Youth Wing Member',
    'Women Wing Member', 'Student Wing Member',
  ];
  static const _activities = [
    'Social Work', 'Political Campaign', 'Voter Registration Drive',
    'Community Service', 'Party Administration', 'Fundraising',
    'Media & Communication', 'Legal Aid',
  ];
  static const _shortPrefixes = ['Mr.', 'Mrs.', 'Ms.', 'Dr.', 'Er.'];
  static const _contactTypes = ['WhatsApp', 'Email', 'Phone', 'Telegram'];
  static const _years = ['2006', '2005', '2004', '2000', '1995', '1990', '1985', '1980'];

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
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _goBack() {
    if (_step > 0) {
      setState(() => _step--);
      _pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: kPrimaryGreen,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: _goBack,
        ),
        title: Image.asset(
          'assets/images/logo_round.png',
          height: 34,
          errorBuilder: (c, e, s) => const Text('AIMIM',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3)),
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
          _StepIndicator(current: _step),
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
                  onAgreedChanged: (v) => setState(() => _s1Agreed = v ?? false),
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
                  onMembershipTypeChanged: (v) => setState(() => _membershipType = v),
                  onActivityChanged: (v) => setState(() => _memberActivity = v),
                  onAgreedChanged: (v) => setState(() => _s2Agreed = v ?? false),
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
                  onMembershipTypeChanged: (v) => setState(() => _membershipType = v),
                  onActivityChanged: (v) => setState(() => _memberActivity = v),
                  onAgreedChanged: (v) => setState(() => _s2Agreed = v ?? false),
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
                        district: _s2District ?? _s1District ?? 'Sant Kabir Nagar',
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
      padding: const EdgeInsets.symmetric(vertical: 10),
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
  const _StepCircle({required this.n, required this.active, required this.done});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? kPrimaryGreen : Colors.grey.shade200,
            border: Border.all(
                color: active ? kPrimaryGreen : Colors.grey.shade400, width: 1.5),
          ),
          child: Center(
            child: done
                ? const Icon(Icons.check, color: Colors.white, size: 16)
                : Text('$n',
                    style: TextStyle(
                        color: active ? Colors.white : Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 13)),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          n == 1 ? 'Enrollment' : n == 2 ? 'Details' : 'Review',
          style: TextStyle(
              fontSize: 9,
              color: active ? kPrimaryGreen : Colors.grey,
              fontWeight: active ? FontWeight.w600 : FontWeight.normal),
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
      width: 60,
      height: 2,
      margin: const EdgeInsets.only(bottom: 14),
      color: active ? kPrimaryGreen : Colors.grey.shade300,
    );
  }
}

// ── Help button ─────────────────────────────────────────────────────────────

class _HelpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF25D366),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          Text('Help?',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
          SizedBox(width: 4),
          Icon(Icons.chat_rounded, color: Colors.white, size: 14),
        ],
      ),
    );
  }
}

// ── Step 1: Enrollment ──────────────────────────────────────────────────────

class _Step1 extends StatelessWidget {
  final List<String> states, districts, shortPrefixes, contactTypes, years;
  final String? selectedState, selectedDistrict, shortPrefix, gender, dobYear, contactType;
  final TextEditingController epicController, fullNameController,
      shortNameController, mobileController, additionalContactController;
  final bool agreed;
  final ValueChanged<String?> onStateChanged, onDistrictChanged,
      onPrefixChanged, onGenderChanged, onYearChanged, onContactTypeChanged;
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
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Center(
            child: Text('MEMBER APPLICATION FORM',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: kDarkGreen,
                    letterSpacing: 0.5)),
          ),
          const SizedBox(height: 8),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: kPrimaryGreen,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text('Login id:  p.m.ajjukhan@gmail.com',
                  style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ),
          const SizedBox(height: 16),

          _FieldLabel('State Name', required: true),
          _DropdownField(
            hint: 'Select Your Residence State',
            value: selectedState,
            items: states,
            onChanged: onStateChanged,
          ),
          const SizedBox(height: 10),

          _FieldLabel('District Name', required: true),
          _DropdownField(
            hint: 'Select Your Residence District',
            value: selectedDistrict,
            items: districts,
            onChanged: onDistrictChanged,
          ),
          const SizedBox(height: 10),

          _FieldLabel('EPIC · Voter Id Number', optional: true),
          Row(
            children: [
              SizedBox(
                width: 110,
                child: _DropdownField(
                  hint: 'Select State',
                  value: selectedState,
                  items: states,
                  onChanged: onStateChanged,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _InputField(
                  controller: epicController,
                  hint: 'EPIC/Voter Card Number',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Enrollment number pill
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF0D2B3E),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('ENROLLMENT NO. ',
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.w600,
                          fontSize: 13)),
                  Text('302-123456',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w900,
                          fontSize: 15, letterSpacing: 1)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),

          _FieldLabel('Member Full Name', required: true),
          _InputField(
            controller: fullNameController,
            hint: 'Enter Full Name as per Documents',
          ),
          const SizedBox(height: 10),

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
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _InputField(
                  controller: shortNameController,
                  hint: 'Enter Short or Nick name',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

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
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _FieldLabelWithInfo('Age', required: true,
                        note: '(18+ Only)'),
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
          const SizedBox(height: 10),

          _FieldLabel('Mobile Number', optional: true),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: const Text('IN  +91',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _InputField(
                  controller: mobileController,
                  hint: 'Enter Mobile Number',
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          _FieldLabelWithInfo('Additional Contact', optional: true),
          Row(
            children: [
              SizedBox(
                width: 120,
                child: _DropdownField(
                  hint: 'Select Type',
                  value: contactType,
                  items: contactTypes,
                  onChanged: onContactTypeChanged,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _InputField(
                  controller: additionalContactController,
                  hint: 'Enter Mobile or Email',
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          _TermsRow(agreed: agreed, onChanged: onAgreedChanged),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onReset,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black87,
                    side: const BorderSide(color: Colors.black26),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('RESET',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: agreed ? onNext : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kDarkGreen,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('NEXT & PREVIEW',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// ── Step 2 / Step 3 (shared layout, different bottom button) ────────────────

class _Step2 extends StatelessWidget {
  final List<String> states, districts, assemblies, membershipTypes,
      activities, years;
  final TextEditingController nameController, contactController;
  final String? gender, dobYear, selectedState, selectedDistrict,
      selectedAssembly, membershipType, memberActivity;
  final bool agreed;
  final bool isFinalStep;
  final ValueChanged<String?> onGenderChanged, onYearChanged, onStateChanged,
      onDistrictChanged, onAssemblyChanged, onMembershipTypeChanged,
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
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card header
            Row(
              children: [
                const Text('AIMIM Member Enrollment: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13)),
                Text('302-123456',
                    style: const TextStyle(
                        color: kPrimaryGreen,
                        fontWeight: FontWeight.w900,
                        fontSize: 14)),
              ],
            ),
            const SizedBox(height: 2),
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
            const SizedBox(height: 10),

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
                const SizedBox(width: 8),
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
            const SizedBox(height: 10),

            _FieldLabelWithInfo('Mobile or E-mail Address', optional: true),
            _InputField(
              controller: contactController,
              hint: 'Enter Mobile Number or E-mail',
            ),
            const SizedBox(height: 10),

            _FieldLabelWithInfo('State Name', required: true),
            _DropdownField(
              hint: 'Select Your Residence State',
              value: selectedState,
              items: states,
              onChanged: onStateChanged,
            ),
            const SizedBox(height: 10),

            _FieldLabel('District Name', required: true),
            _DropdownField(
              hint: 'Select Your Residence District',
              value: selectedDistrict,
              items: districts,
              onChanged: onDistrictChanged,
            ),
            const SizedBox(height: 10),

            _FieldLabel('Assembly · Vidhan Sabha', required: true),
            _DropdownField(
              hint: 'Select AC · Assembly Constituency',
              value: selectedAssembly,
              items: assemblies,
              onChanged: onAssemblyChanged,
            ),
            const SizedBox(height: 10),

            _FieldLabelWithInfo('Membership Type', required: true),
            _DropdownField(
              hint: 'Select Membership Programe',
              value: membershipType,
              items: membershipTypes,
              onChanged: onMembershipTypeChanged,
            ),
            const SizedBox(height: 10),

            _FieldLabelWithInfo('Member Activity', required: true),
            _DropdownField(
              hint: 'Select Your Activity in AIMIM Party',
              value: memberActivity,
              items: activities,
              onChanged: onActivityChanged,
            ),
            const SizedBox(height: 14),

            _TermsRow(agreed: agreed, onChanged: onAgreedChanged),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onBack,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      side: const BorderSide(color: Colors.black26),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('BACK',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: agreed ? onNext : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kDarkGreen,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      isFinalStep ? 'FINAL SUBMIT' : 'NEXT',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
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
  const _FieldLabel(this.text,
      {this.required = false, this.optional = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(text,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: kDarkGreen)),
          if (required)
            const Text(' *',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          if (optional)
            const Text('  (OPTIONAL)',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.normal)),
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
  const _FieldLabelWithInfo(this.text,
      {this.required = false, this.optional = false, this.note});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(text,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: kDarkGreen)),
          if (required)
            const Text(' *',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          if (optional)
            const Text('  (OPTIONAL)',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.normal)),
          if (note != null)
            Text('  $note',
                style: const TextStyle(color: Colors.grey, fontSize: 10)),
          const SizedBox(width: 4),
          const Icon(Icons.info_outline, size: 13, color: Colors.grey),
        ],
      ),
    );
  }
}

class _DropdownField extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  const _DropdownField({
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hint,
              style: const TextStyle(color: Colors.grey, fontSize: 13)),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          items: items
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e,
                        style: const TextStyle(fontSize: 13),
                        overflow: TextOverflow.ellipsis),
                  ))
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
  const _InputField({
    required this.controller,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.inputFormatters = const [],
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: const TextStyle(fontSize: 13),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: kPrimaryGreen, width: 1.5),
        ),
        filled: true,
        fillColor: Colors.white,
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
        const SizedBox(width: 4),
        RichText(
          text: TextSpan(
            style: const TextStyle(
                fontSize: 12, color: Colors.black87),
            children: [
              const TextSpan(text: 'I AGREE '),
              TextSpan(
                text: 'TERMS',
                style: const TextStyle(
                    color: kPrimaryGreen,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
              ),
              const TextSpan(text: ' & '),
              TextSpan(
                text: 'CONDITIONS.',
                style: const TextStyle(
                    color: kPrimaryGreen,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
