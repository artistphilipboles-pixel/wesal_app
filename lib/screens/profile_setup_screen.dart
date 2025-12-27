import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wesal_app/data/arab_locations.dart';
import 'package:wesal_app/models/session.dart';
import 'package:wesal_app/screens/home_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  int _step = 0;
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nicknameController = TextEditingController();
  String? _gender;
  String? _marital;
  String? _country;
  String? _city;
  final List<String> _selectedInterests = [];
  bool _albumLocked = true;
  Uint8List? _avatarBytes;
  final List<Uint8List> _albumBytes = [];
  bool _encryptAlbum = true;
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
  final List<String> _lifestyleOptions = [
    'رفاهية',
    'سفر',
    'فنون',
    'تقنية',
    'رياضة',
    'طهي',
    'موسيقى',
    'ألعاب',
  ];
  final Set<String> _lifestyleTags = {};
  String? _error;

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  Future<void> _pickAvatar() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      imageQuality: 85,
    );
    if (file != null) {
      final bytes = await file.readAsBytes();
      setState(() => _avatarBytes = bytes);
    }
  }

  Future<void> _pickAlbumImages() async {
    final picker = ImagePicker();
    final files = await picker.pickMultiImage(maxWidth: 1200, imageQuality: 85);
    if (files.isNotEmpty) {
      final newBytes = <Uint8List>[];
      for (final f in files) {
        final b = await f.readAsBytes();
        newBytes.add(b);
        if (newBytes.length >= 6) break;
      }
      setState(() {
        _albumBytes
          ..clear()
          ..addAll(newBytes.take(6));
      });
    }
  }

  bool _validateStep() {
    if (_step == 0) {
      final emailValid = RegExp(
        r'^[^@]+@[^@]+\.[^@]+',
      ).hasMatch(_emailController.text.trim());
      final phoneValid = RegExp(
        r'^[0-9]{8,15}$',
      ).hasMatch(_phoneController.text.trim());
      if (!emailValid || !phoneValid) {
        setState(
          () => _error = 'الرجاء إدخال بريد إلكتروني صحيح ورقم هاتف صحيح',
        );
        return false;
      }
      setState(() => _error = null);
    } else if (_step == 1) {
      if (_nicknameController.text.trim().isEmpty ||
          _gender == null ||
          _marital == null) {
        setState(() => _error = 'يرجى استكمال الحقول المطلوبة');
        return false;
      }
      setState(() => _error = null);
    } else if (_step == 2) {
      if (_country == null || _city == null) {
        setState(() => _error = 'اختر الدولة والمدينة');
        return false;
      }
      setState(() => _error = null);
    }
    return true;
  }

  void _next() {
    if (!_validateStep()) return;
    if (_step < 4) {
      setState(() {
        _step++;
      });
    } else {
      AppSession.profile.email = _emailController.text.trim();
      AppSession.profile.phone = _phoneController.text.trim();
      AppSession.profile.nickname = _nicknameController.text.trim();
      AppSession.profile.gender = _gender;
      AppSession.profile.maritalStatus = _marital;
      AppSession.profile.country = _country;
      AppSession.profile.city = _city;
      AppSession.profile.interests = List.from(_selectedInterests);
      AppSession.profile.privateAlbumLocked = _encryptAlbum;
      AppSession.profile.avatarBytes = _avatarBytes;
      AppSession.profile.albumBytes = List.from(_albumBytes);
      AppSession.profile.lifestyleTags = List.from(_lifestyleTags);
      AppSession.isGuest = false;
      AppSession.isRegistered = true;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false,
      );
    }
  }

  Widget _glass(Widget child) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
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
              if (_error != null) ...[
                const SizedBox(height: 8),
                Text(
                  _error!,
                  style: GoogleFonts.tajawal(color: Colors.redAccent),
                ),
              ],
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      if (_step == 0)
                        _glass(
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'البريد الإلكتروني',
                                style: GoogleFonts.tajawal(color: Colors.white),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: GoogleFonts.tajawal(color: Colors.white),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: Colors.white.withValues(
                                        alpha: 0.3,
                                      ),
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
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'رقم الهاتف',
                                style: GoogleFonts.tajawal(color: Colors.white),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                style: GoogleFonts.tajawal(color: Colors.white),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: Colors.white.withValues(
                                        alpha: 0.3,
                                      ),
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
                                  prefixIcon: const Icon(
                                    Icons.phone,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (_step == 1)
                        _glass(
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'اسم مستعار',
                                style: GoogleFonts.tajawal(color: Colors.white),
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
                      if (_step == 2)
                        _glass(
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
                                      color: Colors.white.withValues(
                                        alpha: 0.3,
                                      ),
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
                                      color: Colors.white.withValues(
                                        alpha: 0.3,
                                      ),
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
                      if (_step == 3)
                        _glass(
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
                              const SizedBox(height: 16),
                              Text(
                                'وسوم نمط الحياة',
                                style: GoogleFonts.tajawal(color: Colors.white),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: _lifestyleOptions.map((opt) {
                                  final selected = _lifestyleTags.contains(opt);
                                  return FilterChip(
                                    selected: selected,
                                    label: Text(
                                      opt,
                                      style: GoogleFonts.tajawal(),
                                    ),
                                    onSelected: (val) {
                                      setState(() {
                                        if (val) {
                                          _lifestyleTags.add(opt);
                                        } else {
                                          _lifestyleTags.remove(opt);
                                        }
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      if (_step == 4)
                        _glass(
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'الوسائط والخصوصية',
                                style: GoogleFonts.tajawal(color: Colors.white),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 250),
                                    child: _avatarBytes == null
                                        ? CircleAvatar(
                                            key: const ValueKey(
                                              'avatar_placeholder',
                                            ),
                                            radius: 40,
                                            backgroundColor: Colors.white
                                                .withValues(alpha: 0.2),
                                            child: const Icon(
                                              Icons.person,
                                              color: Colors.white,
                                              size: 40,
                                            ),
                                          )
                                        : CircleAvatar(
                                            key: const ValueKey('avatar_image'),
                                            radius: 40,
                                            backgroundImage: MemoryImage(
                                              _avatarBytes!,
                                            ),
                                          ),
                                  ),
                                  const SizedBox(width: 16),
                                  ElevatedButton.icon(
                                    onPressed: _pickAvatar,
                                    icon: const Icon(Icons.camera_alt),
                                    label: Text(
                                      'صورة الملف',
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
                                'ألبوم الصور الخاص',
                                style: GoogleFonts.tajawal(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.white24),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          _encryptAlbum
                                              ? Icons.lock
                                              : Icons.lock_open,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            _encryptAlbum
                                                ? 'تشفير الألبوم مفعّل'
                                                : 'الألبوم غير مشفّر',
                                            style: GoogleFonts.tajawal(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Switch(
                                          value: _encryptAlbum,
                                          onChanged: (v) =>
                                              setState(() => _encryptAlbum = v),
                                          activeColor: const Color(0xFF7851A9),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    ElevatedButton.icon(
                                      onPressed: _pickAlbumImages,
                                      icon: const Icon(Icons.photo_library),
                                      label: Text(
                                        'اختيار صور (حتى 6)',
                                        style: GoogleFonts.tajawal(),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: const Color(
                                          0xFF191970,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: List.generate(6, (index) {
                                        final hasImage =
                                            index < _albumBytes.length;
                                        return AnimatedContainer(
                                          duration: const Duration(
                                            milliseconds: 250,
                                          ),
                                          width: 90,
                                          height: 90,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withValues(
                                              alpha: 0.08,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            border: Border.all(
                                              color: Colors.white24,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withValues(
                                                  alpha: 0.05,
                                                ),
                                                blurRadius: 8,
                                                offset: const Offset(0, 4),
                                              ),
                                            ],
                                          ),
                                          child: Stack(
                                            children: [
                                              if (hasImage)
                                                Positioned.fill(
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                    child: Image.memory(
                                                      _albumBytes[index],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                )
                                              else
                                                Center(
                                                  child: Icon(
                                                    Icons.image,
                                                    color: Colors.white
                                                        .withValues(alpha: 0.6),
                                                  ),
                                                ),
                                              if (_encryptAlbum)
                                                Positioned(
                                                  right: 6,
                                                  top: 6,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withValues(
                                                            alpha: 0.3,
                                                          ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                    ),
                                                    child: const Icon(
                                                      Icons.lock,
                                                      color: Colors.white,
                                                      size: 16,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                  ],
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
