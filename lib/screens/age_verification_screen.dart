import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wesal_app/screens/privacy_setup_screen.dart';
import 'package:wesal_app/screens/legal_terms_screen.dart';

class AgeVerificationScreen extends StatefulWidget {
  const AgeVerificationScreen({super.key});

  @override
  State<AgeVerificationScreen> createState() => _AgeVerificationScreenState();
}

class _AgeVerificationScreenState extends State<AgeVerificationScreen> {
  final TextEditingController _ageController = TextEditingController();
  String? _errorMessage;
  bool _isValid = false;

  void _validateAgeInput(String input) {
    final String trimmed = input.trim();
    final int? age = int.tryParse(trimmed);
    if (trimmed.isEmpty || age == null) {
      setState(() {
        _isValid = false;
        _errorMessage = null;
      });
      return;
    }
    if (age < 21 || age > 99) {
      setState(() {
        _isValid = false;
        _errorMessage = 'عذراً، يجب أن يكون عمرك بين 21 و 99 عاماً للمتابعة';
      });
      return;
    }
    setState(() {
      _isValid = true;
      _errorMessage = null;
    });
  }

  void navigateToPrivacy() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LegalTermsScreen()),
    );
  }

  @override
  void dispose() {
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('تأكيد العمر', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
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
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.verified_user_outlined,
                  size: 80,
                  color: Colors.white,
                ),
                const SizedBox(height: 24),
                const Text(
                  'مرحباً بك',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Tajawal',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'لضمان مجتمع ناضج ومسؤول، يرجى تأكيد عمرك.\n(يجب أن يكون العمر بين 21 و 99)',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Input Field Container
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white30),
                  ),
                  child: TextField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 2,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                    ],
                    style: GoogleFonts.tajawal(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: '21',
                      hintStyle: const TextStyle(
                        color: Colors.white38,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                      errorText: _errorMessage,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.white.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Color(0xFF7851A9),
                          width: 2,
                        ),
                      ),
                    ),
                    onChanged: _validateAgeInput,
                  ),
                ),

                const SizedBox(height: 40),

                SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _isValid ? navigateToPrivacy : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isValid
                          ? const Color(0xFF191970)
                          : Colors.grey,
                      foregroundColor: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'متابعة',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
