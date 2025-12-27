import 'package:flutter/material.dart';
import 'package:wesal_app/widgets/user_card.dart';
import 'package:wesal_app/screens/notifications_screen.dart';
import 'package:wesal_app/screens/profile_screen.dart';
import 'package:wesal_app/screens/private_chat_screen.dart';
import 'package:wesal_app/screens/public_chat_screen.dart';
import 'package:wesal_app/screens/discovery_screen.dart';
import 'package:wesal_app/screens/bubbles_screen.dart';
import 'package:wesal_app/screens/mailbox_screen.dart';
import 'package:wesal_app/models/session.dart';
import 'dart:ui';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const ProfileScreen(),
    const DiscoveryScreen(),
    const BubblesScreen(),
    const MailboxScreen(),
    const PublicChatScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // For glass effect if needed
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0
              ? 'حسابي'
              : _selectedIndex == 1
              ? 'اكتشف'
              : _selectedIndex == 2
              ? 'الفقاعات'
              : _selectedIndex == 3
              ? 'صندوق البريد'
              : 'الدردشة العامة',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF191970), Color(0xFF7851A9)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF3F4F6), Color(0xFFE1E5EB)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              if (AppSession.isGuest)
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                        child: const Text(
                          'زائر مؤقت: الرجاء التسجيل للتفاعل والدردشة',
                          style: TextStyle(color: Colors.black87, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: IndexedStack(index: _selectedIndex, children: _pages),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'حسابي',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.filter_alt),
                  label: 'اكتشف',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bubble_chart),
                  label: 'الفقاعات',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.mail),
                  label: 'البريد',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat),
                  label: 'العامة',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: const Color(0xFF7851A9),
              unselectedItemColor: Colors.grey,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
        ),
      ),
    );
  }
}

class DiscoverFeed extends StatefulWidget {
  const DiscoverFeed({super.key});

  @override
  State<DiscoverFeed> createState() => _DiscoverFeedState();
}

class _DiscoverFeedState extends State<DiscoverFeed> {
  // Mock data for the feed
  final List<Map<String, dynamic>> _allUsers = [
    {
      'nickname': 'أحمد',
      'age': 25,
      'country': 'السعودية',
      'status': 'يبحث عن زواج جاد',
      'isVerified': true,
    },
    {
      'nickname': 'سارة',
      'age': 23,
      'country': 'مصر',
      'status': 'مهتمة بالتعارف الجدي',
      'isVerified': false,
    },
    {
      'nickname': 'عمر',
      'age': 28,
      'country': 'الإمارات',
      'status': 'رائد أعمال، يبحث عن شريكة حياة',
      'isVerified': true,
    },
    {
      'nickname': 'نورة',
      'age': 24,
      'country': 'الكويت',
      'status': 'تحب القراءة والسفر',
      'isVerified': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      itemCount: _allUsers.length,
      itemBuilder: (context, index) {
        final user = _allUsers[index];
        return UserCard(
          nickname: user['nickname'],
          age: user['age'],
          country: user['country'],
          status: user['status'],
          isVerified: user['isVerified'] ?? false,
          isGuest: AppSession.isGuest,
          onWave: () => _showMatchOverlay(user['nickname']),
        );
      },
    );
  }

  void _showMatchOverlay(String nickname) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (ctx) {
        return Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.25)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.waving_hand,
                      color: Colors.amber,
                      size: 40,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'لقد حدث وصال!',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Tajawal',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'يمكنك الآن البدء بمحادثة خاصة وآمنة',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        fontFamily: 'Tajawal',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.lock, color: Colors.white),
                        label: const Text(
                          'بدء محادثة خاصة',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7851A9),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(ctx);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  PrivateChatScreen(peerName: nickname),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
