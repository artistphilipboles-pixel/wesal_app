import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wesal_app/screens/profile_setup_screen.dart';
import 'package:wesal_app/widgets/wesal_logo.dart';

class LegalTermsScreen extends StatefulWidget {
  const LegalTermsScreen({super.key});

  @override
  State<LegalTermsScreen> createState() => _LegalTermsScreenState();
}

class _LegalTermsScreenState extends State<LegalTermsScreen> {
  bool _accepted = false;

  final String _legalText = '''
اتفاقية قانونية ملزمة – جدار قانوني لتطبيق "وصال"

وفقاً لأحكام القانون رقم 175 لسنة 2018 بشأن مكافحة جرائم تقنية المعلومات في جمهورية مصر العربية، يقر المستخدم ويوافق على ما يلي:

1) دور المنصة:
- "وصال" منصة تقنية محايدة تعمل كوسيط رقمي لتيسير التواصل الشخصي والاجتماعي بين المستخدمين دون تدخل في المحتوى الخاص أو إدارة المحادثات.
- لا تتحمل إدارة "وصال" أي مسؤولية قانونية أو مدنية أو جنائية عن أي محتوى يتم تداوله بشكل خاص بين المستخدمين، وكل مستخدم مسؤول بالكامل عن أفعاله وتفاعلاته.

2) المسؤولية القانونية:
- المستخدم يلتزم بالامتثال الكامل لكافة القوانين واللوائح المعمول بها، ويحظر استخدام التطبيق في أي نشاط يخالف القانون أو النظام العام أو الآداب العامة.
- أي إساءة استخدام أو نشاط غير قانوني يترتب عليه مسؤولية كاملة على المستخدم وحده.

3) الحماية والخصوصية:
- تحترم المنصة خصوصية المستخدمين وتوفر بيئة للتعبير والاتصال دون تمييز، مع التشديد على منع الأنشطة غير القانونية أو المسيئة.

4) الإقرار:
- أقر بأنني قرأت وفهمت كافة البنود أعلاه، وأوافق عليها، وأتحمل كامل المسؤولية القانونية عن استخدامي للتطبيق.
''';

  Future<void> _persistAcceptance() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'legal_acceptance_at',
      DateTime.now().toIso8601String(),
    );
  }

  void _continue() async {
    await _persistAcceptance();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ProfileSetupScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'الجدار القانوني',
          style: GoogleFonts.tajawal(color: Colors.white),
        ),
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
              const SizedBox(height: 16),
              const WesalLogo(size: 60),
              const SizedBox(height: 10),
              Text(
                'الشروط والأحكام القانونية',
                style: GoogleFonts.tajawal(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      _legalText,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.tajawal(
                        color: Colors.white,
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CheckboxListTile(
                  value: _accepted,
                  onChanged: (v) => setState(() => _accepted = v ?? false),
                  title: Text(
                    'أوافق على كافة الشروط والمسؤولية القانونية',
                    style: GoogleFonts.tajawal(color: Colors.white),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  checkboxShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 20.0,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _accepted ? _continue : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF191970),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: Text(
                      'موافقة ومتابعة',
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
