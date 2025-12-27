import 'package:flutter/material.dart';
import 'package:wesal_app/screens/age_verification_screen.dart';
import 'package:wesal_app/widgets/wesal_logo.dart';

class LegalAgreementScreen extends StatefulWidget {
  const LegalAgreementScreen({super.key});

  @override
  State<LegalAgreementScreen> createState() => _LegalAgreementScreenState();
}

class _LegalAgreementScreenState extends State<LegalAgreementScreen> {
  bool _isAccepted = false;
  final ScrollController _scrollController = ScrollController();

  final String _legalText = '''
اتفاقية الاستخدام وسياسة الخصوصية لتطبيق "وصال"

يرجى قراءة هذه الشروط والأحكام بعناية قبل البدء في استخدام التطبيق. استخدامك للتطبيق يعني موافقتك الكاملة والملزمة على كافة البنود الواردة أدناه.

1. إخلاء المسؤولية القانونية
- إدارة تطبيق "وصال" توفر منصة للتواصل الاجتماعي فقط، ولا تتحمل أي مسؤولية قانونية أو مدنية أو جنائية عن المحتوى الذي يتم تداوله بين المستخدمين.
- المستخدم هو المسؤول الوحيد عن أي نصوص أو صور أو بيانات يقوم بنشرها أو إرسالها عبر التطبيق.
- تخلي إدارة التطبيق مسؤوليتها تماماً عن أي سوء استخدام للخدمة أو أي أضرار قد تنتج عن التعامل مع مستخدمين آخرين.

2. الامتثال للقوانين (جمهورية مصر العربية)
- يتعهد المستخدم بالامتثال الكامل لجميع القوانين المعمول بها في جمهورية مصر العربية، بما في ذلك القانون رقم 175 لسنة 2018 بشأن مكافحة جرائم تقنية المعلومات.
- يُحظر تماماً استخدام التطبيق لأغراض سياسية، أو للتحريض على العنف، أو نشر الشائعات، أو الإساءة للأديان، أو أي أنشطة تخالف النظام العام والآداب.

3. الخصوصية وأمن البيانات
- نحن نلتزم بحماية خصوصية بياناتك بأعلى المعايير التقنية (تشفير، حماية الخوادم).
- ومع ذلك، يقر المستخدم بأنه لا توجد وسيلة نقل بيانات عبر الإنترنت آمنة بنسبة 100%، ويتحمل مسؤولية الحفاظ على سرية بيانات دخوله.

4. السلوك المحظور
- يمنع منعاً باتاً التحرش، الابتزاز، أو إرسال محتوى إباحي أو مسيء.
- تحتفظ إدارة التطبيق بالحق الكامل في حظر أي مستخدم يخالف هذه الشروط فوراً ودون سابق إنذار، مع الاحتفاظ بالحق في تقديم بياناته للجهات المختصة في حال وجود مخالفة قانونية جسيمة.

5. التعديلات
- يحق لإدارة التطبيق تعديل هذه الشروط في أي وقت، ويعتبر استمرارك في استخدام التطبيق موافقة ضمنية على التعديلات.

إقرار:
أقر أنا المستخدم بأنني قرأت كافة الشروط أعلاه، وأوافق عليها، وأتحمل كامل المسؤولية القانونية عن استخدامي للتطبيق.
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF191970), // Deep Midnight Blue
              Color(0xFF7851A9), // Soft Royal Purple
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const WesalLogo(size: 60),
              const SizedBox(height: 10),
              const Text(
                'الشروط والأحكام',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tajawal',
                ),
              ),
              const SizedBox(height: 20),

              // Legal Text Container
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Scrollbar(
                    controller: _scrollController,
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Text(
                        _legalText,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          height: 1.6,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Acceptance Checkbox
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white24),
                ),
                child: CheckboxListTile(
                  value: _isAccepted,
                  onChanged: (val) {
                    setState(() {
                      _isAccepted = val ?? false;
                    });
                  },
                  activeColor: const Color(0xFF7851A9),
                  title: const Text(
                    'أوافق على جميع الشروط والأحكام وسياسة الخصوصية',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),

              const SizedBox(height: 20),

              // Action Button
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _isAccepted
                        ? () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const AgeVerificationScreen(),
                              ),
                            );
                          }
                        : null, // Disabled if not accepted
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF191970),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'موافق ومتابعة',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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
