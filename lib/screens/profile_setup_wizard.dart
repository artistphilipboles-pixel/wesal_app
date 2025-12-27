import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wesal_app/models/session.dart';
import 'package:wesal_app/screens/home_screen.dart';
import 'package:wesal_app/data/arab_locations.dart';

class ProfileSetupWizard extends StatefulWidget {
  const ProfileSetupWizard({super.key});

  @override
  State<ProfileSetupWizard> createState() => _ProfileSetupWizardState();
}

class _ProfileSetupWizardState extends State<ProfileSetupWizard> {
  int _step = 0;
  final _nicknameController = TextEditingController();
  String? _gender;
  String? _marital;
  String? _country;
  String? _city;
  final List<String> _selectedInterests = [];
  bool _albumLocked = true;
  late final Map<String, List<String>> _locations = arabCountriesCities;
  final List<String> _interestsOptions = [
    'تعارف',
    'محادثة متعددة الوسائط',
    'لقاء',
    'شريك حياة',
    'شريك سكن',
    'ارتباط',
    'زواج',
  ];

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  void _next() {
    if (_step < 4) {
      setState(() {
        _step++;
      });
    } else {
      AppSession.profile.nickname = _nicknameController.text.trim();
      AppSession.profile.gender = _gender;
      AppSession.profile.maritalStatus = _marital;
      AppSession.profile.country = _country;
      AppSession.profile.city = _city;
      AppSession.profile.interests = List.from(_selectedInterests);
      AppSession.profile.privateAlbumLocked = _albumLocked;
      AppSession.isGuest = false;
      AppSession.isRegistered = true;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false,
      );
    }
  }

  Widget _buildStepContainer(Widget child) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white24),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'إعداد الملف الشخصي',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF191970), Color(0xFF7851A9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text(
                'الخطوة ${_step + 1} من 5',
                style: GoogleFonts.tajawal(color: Colors.white70),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      if (_step == 0)
                        _buildStepContainer(
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'اسم مستعار',
                                style: GoogleFonts.tajawal(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: _nicknameController,
                                style: GoogleFonts.tajawal(color: Colors.white),
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: 'اكتب لقبك',
                                  hintStyle: GoogleFonts.tajawal(
                                    color: Colors.white38,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    borderSide: BorderSide(
                                      color: Color(0xFF7851A9),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'النوع',
                                style: GoogleFonts.tajawal(color: Colors.white),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children:
                                    [
                                      'ذكر',
                                      'أنثى',
                                      'طيف ذكر',
                                      'طيف أنثى',
                                      'آخر',
                                    ].map((g) {
                                      final selected = _gender == g;
                                      return ChoiceChip(
                                        label: Text(
                                          g,
                                          style: GoogleFonts.tajawal(),
                                        ),
                                        selected: selected,
                                        onSelected: (_) =>
                                            setState(() => _gender = g),
                                      );
                                    }).toList(),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'الحالة الاجتماعية',
                                style: GoogleFonts.tajawal(color: Colors.white),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children:
                                    [
                                      'أعزب',
                                      'متزوج',
                                      'منفصل',
                                      'زوجان',
                                      'كابل',
                                    ].map((m) {
                                      final selected = _marital == m;
                                      return ChoiceChip(
                                        label: Text(
                                          m,
                                          style: GoogleFonts.tajawal(),
                                        ),
                                        selected: selected,
                                        onSelected: (_) =>
                                            setState(() => _marital = m),
                                      );
                                    }).toList(),
                              ),
                            ],
                          ),
                        ),
                      if (_step == 1)
                        _buildStepContainer(
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'الدولة',
                                style: GoogleFonts.tajawal(color: Colors.white),
                              ),
                              const SizedBox(height: 8),
                              DropdownButtonFormField<String>(
                                value: _country,
                                dropdownColor: const Color(0xFF191970),
                                items: _locations.keys
                                    .map(
                                      (e) => DropdownMenuItem<String>(
                                        value: e,
                                        child: Text(
                                          e,
                                          style: GoogleFonts.tajawal(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (v) {
                                  setState(() {
                                    _country = v;
                                    _city = null;
                                  });
                                },
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    borderSide: BorderSide(
                                      color: Color(0xFF7851A9),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'المدينة',
                                style: GoogleFonts.tajawal(color: Colors.white),
                              ),
                              const SizedBox(height: 8),
                              DropdownButtonFormField<String>(
                                value: _city,
                                dropdownColor: const Color(0xFF191970),
                                items:
                                    (_country == null
                                            ? []
                                            : _locations[_country]!)
                                        .map(
                                          (e) => DropdownMenuItem<String>(
                                            value: e,
                                            child: Text(
                                              e,
                                              style: GoogleFonts.tajawal(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                onChanged: (v) => setState(() => _city = v),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    borderSide: BorderSide(
                                      color: Color(0xFF7851A9),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (_step == 2)
                        _buildStepContainer(
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'الاهتمامات',
                                style: GoogleFonts.tajawal(color: Colors.white),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: _interestsOptions.map((opt) {
                                  final selected = _selectedInterests.contains(
                                    opt,
                                  );
                                  return FilterChip(
                                    selected: selected,
                                    label: Text(
                                      opt,
                                      style: GoogleFonts.tajawal(),
                                    ),
                                    onSelected: (val) {
                                      setState(() {
                                        if (val) {
                                          _selectedInterests.add(opt);
                                        } else {
                                          _selectedInterests.remove(opt);
                                        }
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      if (_step == 3)
                        _buildStepContainer(
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'الصورة الشخصية',
                                style: GoogleFonts.tajawal(color: Colors.white),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.white.withOpacity(
                                      0.2,
                                    ),
                                    child: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.upload),
                                    label: Text(
                                      'رفع صورة',
                                      style: GoogleFonts.tajawal(),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: const Color(0xFF191970),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'الألبوم الخاص',
                                style: GoogleFonts.tajawal(color: Colors.white),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.white24),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      _albumLocked
                                          ? Icons.lock
                                          : Icons.lock_open,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        _albumLocked
                                            ? 'الألبوم الخاص مغلق افتراضياً'
                                            : 'الألبوم الخاص مفتوح',
                                        style: GoogleFonts.tajawal(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => setState(
                                        () => _albumLocked = !_albumLocked,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFF7851A9,
                                        ),
                                        foregroundColor: Colors.white,
                                      ),
                                      child: Text(
                                        _albumLocked
                                            ? 'طلب الوصول'
                                            : 'إلغاء القفل',
                                        style: GoogleFonts.tajawal(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (_step == 4)
                        _buildStepContainer(
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'مراجعة المعلومات',
                                style: GoogleFonts.tajawal(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'اللقب: ${_nicknameController.text}',
                                style: GoogleFonts.tajawal(
                                  color: Colors.white70,
                                ),
                              ),
                              Text(
                                'النوع: ${_gender ?? ''}',
                                style: GoogleFonts.tajawal(
                                  color: Colors.white70,
                                ),
                              ),
                              Text(
                                'الحالة: ${_marital ?? ''}',
                                style: GoogleFonts.tajawal(
                                  color: Colors.white70,
                                ),
                              ),
                              Text(
                                'الموقع: ${_country ?? ''} - ${_city ?? ''}',
                                style: GoogleFonts.tajawal(
                                  color: Colors.white70,
                                ),
                              ),
                              Text(
                                'الاهتمامات: ${_selectedInterests.join(', ')}',
                                style: GoogleFonts.tajawal(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _next,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF191970),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Text(
                      _step < 4 ? 'التالي' : 'إنهاء',
                      style: GoogleFonts.tajawal(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
