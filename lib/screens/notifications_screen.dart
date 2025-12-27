import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = [
      {'title': 'تلويح جديد', 'body': 'أحمد لوح لك 👋', 'time': 'منذ دقيقتين'},
      {'title': 'طلب مراسلة', 'body': 'سارة تود المحادثة', 'time': 'منذ ساعة'},
      {'title': 'النظام', 'body': 'مرحباً بك في وصال!', 'time': 'منذ يوم'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('الإشعارات', style: TextStyle(color: Colors.white)),
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
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.separated(
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final notif = notifications[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              backgroundColor: const Color(0xFF7851A9).withOpacity(0.1),
              child: const Icon(Icons.notifications, color: Color(0xFF7851A9)),
            ),
            title: Text(notif['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(notif['body']!),
            trailing: Text(notif['time']!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          );
        },
      ),
    );
  }
}
