import 'package:flutter/material.dart';
import 'package:wesal_app/widgets/privacy_item_tile.dart';
import 'package:wesal_app/screens/home_screen.dart';

class PrivacySetupScreen extends StatefulWidget {
  const PrivacySetupScreen({super.key});

  @override
  State<PrivacySetupScreen> createState() => _PrivacySetupScreenState();
}

class _PrivacySetupScreenState extends State<PrivacySetupScreen> {
  // Map to store state of each item.
  final Map<String, PrivacyState> _privacySettings = {
    'Name': PrivacyState.hidden,
    'Age': PrivacyState.hidden,
    'Photo': PrivacyState.hidden,
    'Status': PrivacyState.hidden,
  };

  // Helper to get Arabic label and Icon
  (String, IconData) _getItemDetails(String key) {
    switch (key) {
      case 'Name':
        return ('الاسم', Icons.person);
      case 'Age':
        return ('العمر', Icons.calendar_today);
      case 'Photo':
        return ('الصورة', Icons.camera_alt);
      case 'Status':
        return ('الحالة', Icons.info_outline);
      default:
        return (key, Icons.help_outline);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'إعدادات الخصوصية',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
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
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: const [
                  Icon(Icons.security, size: 48, color: Color(0xFF7851A9)),
                  SizedBox(height: 16),
                  Text(
                    'تحكم بخصوصيتك',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'قم بإعداد خيارات الخصوصية قبل البدء.\nالوضع الافتراضي هو "مخفي" لسلامتك.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: _privacySettings.entries.map((entry) {
                  final details = _getItemDetails(entry.key);
                  return PrivacyItemTile(
                    label: details.$1,
                    icon: details.$2,
                    currentState: entry.value,
                    onStateChanged: (newState) {
                      setState(() {
                        _privacySettings[entry.key] = newState;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF191970), // Deep Midnight Blue
                      Color(0xFF7851A9), // Soft Royal Purple
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7851A9).withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _onCompleteSetup,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 55),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'إكمال الإعداد والمتابعة',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onCompleteSetup() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (route) => false,
    );
  }
}
