import 'package:flutter/material.dart';
import 'package:wesal_app/widgets/user_card.dart';
import 'package:wesal_app/screens/notifications_screen.dart';
import 'package:wesal_app/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DiscoverFeed(),
    const Center(child: Text('المحادثات', style: TextStyle(fontSize: 24))),
    const Center(child: Text('اهتماماتي', style: TextStyle(fontSize: 24))),
    const ProfileScreen(),
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
      appBar: _selectedIndex == 0
          ? AppBar(
              title: const Text('وصال',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
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
            )
          : null,
      body: Container(
        decoration: _selectedIndex == 0
            ? const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFF3F4F6),
                    Color(0xFFE1E5EB),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              )
            : null,
        child: SafeArea(
          child: IndexedStack(index: _selectedIndex, children: _pages),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'اكتشف'),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble),
              label: 'المحادثات',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.interests),
              label: 'اهتمامات',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'حسابي'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF7851A9),
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
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
        );
      },
    );
  }
}
