import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _wavesEnabled = true;
  bool _messagesEnabled = true;
  bool _likesEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الملف الشخصي والإعدادات',
          style: TextStyle(color: Colors.white),
        ),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFF7851A9),
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'ملفي الشخصي',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'إعدادات الإشعارات',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7851A9),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('إشعارات التلويح'),
                    subtitle:
                        const Text('تلقي تنبيهات عندما يلوح لك شخص ما'),
                    value: _wavesEnabled,
                    onChanged: (val) => setState(() => _wavesEnabled = val),
                    activeColor: const Color(0xFF7851A9),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: const Text('طلبات المراسلة'),
                    subtitle: const Text('تلقي تنبيهات للرسائل الجديدة'),
                    value: _messagesEnabled,
                    onChanged: (val) => setState(() => _messagesEnabled = val),
                    activeColor: const Color(0xFF7851A9),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: const Text('الإعجابات'),
                    subtitle:
                        const Text('تلقي تنبيهات عندما يعجب بك شخص ما'),
                    value: _likesEnabled,
                    onChanged: (val) => setState(() => _likesEnabled = val),
                    activeColor: const Color(0xFF7851A9),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: OutlinedButton(
                onPressed: () {
                  // Logout logic
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                child: const Text('تسجيل الخروج'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
