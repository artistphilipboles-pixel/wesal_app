import 'package:flutter/material.dart';
import 'package:wesal_app/models/session.dart';

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
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color(0xFF7851A9),
                    backgroundImage: AppSession.profile.avatarBytes != null
                        ? MemoryImage(AppSession.profile.avatarBytes!)
                        : null,
                    child: AppSession.profile.avatarBytes == null
                        ? const Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          )
                        : null,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    AppSession.profile.nickname ?? 'ملفي الشخصي',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                const Icon(Icons.lock, color: Colors.white),
                const SizedBox(width: 6),
                Text(
                  AppSession.profile.privateAlbumLocked
                      ? 'الألبوم الخاص: مغلق'
                      : 'الألبوم الخاص: مفتوح',
                  style: const TextStyle(
                    color: Color(0xFF7851A9),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(6, (index) {
                final hasImage = index < AppSession.profile.albumBytes.length;
                return Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: hasImage
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: ImageFiltered(
                                  imageFilter:
                                      AppSession.profile.privateAlbumLocked
                                      ? ImageFilter.blur(sigmaX: 8, sigmaY: 8)
                                      : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                                  child: Image.memory(
                                    AppSession.profile.albumBytes[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              if (AppSession.profile.privateAlbumLocked)
                                const Positioned(
                                  right: 6,
                                  top: 6,
                                  child: Icon(Icons.lock, color: Colors.white),
                                ),
                            ],
                          ),
                        )
                      : const Center(
                          child: Icon(Icons.image, color: Colors.white54),
                        ),
                );
              }),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Icon(Icons.verified, color: Colors.white),
                const SizedBox(width: 6),
                const Text(
                  'شارات التحقق',
                  style: TextStyle(
                    color: Color(0xFF7851A9),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7851A9),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Boost Profile'),
                ),
              ],
            ),
            const SizedBox(height: 16),
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
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('إشعارات التلويح'),
                    subtitle: const Text('تلقي تنبيهات عندما يلوح لك شخص ما'),
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
                    subtitle: const Text('تلقي تنبيهات عندما يعجب بك شخص ما'),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
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
