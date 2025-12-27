import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wesal_app/widgets/user_card.dart';
import 'package:wesal_app/models/session.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  String? _gender;
  RangeValues _ageRange = const RangeValues(18, 45);
  String? _marital;
  final Set<String> _interests = {};

  final List<Map<String, dynamic>> _users = [
    {
      'nickname': 'أحمد',
      'age': 25,
      'gender': 'ذكر',
      'marital': 'أعزب',
      'interests': ['تعارف'],
    },
    {
      'nickname': 'سارة',
      'age': 23,
      'gender': 'أنثى',
      'marital': 'أعزب',
      'interests': ['شريك حياة', 'زواج'],
    },
    {
      'nickname': 'عمر',
      'age': 30,
      'gender': 'ذكر',
      'marital': 'متزوج',
      'interests': ['محادثة متعددة الوسائط'],
    },
    {
      'nickname': 'نورة',
      'age': 28,
      'gender': 'أنثى',
      'marital': 'أعزب',
      'interests': ['ارتباط', 'زواج'],
    },
  ];

  List<Map<String, dynamic>> get _filtered {
    return _users.where((u) {
      final ageOk = u['age'] >= _ageRange.start && u['age'] <= _ageRange.end;
      final genderOk = _gender == null || u['gender'] == _gender;
      final maritalOk = _marital == null || u['marital'] == _marital;
      final interestsOk =
          _interests.isEmpty ||
          _interests.any((i) => (u['interests'] as List).contains(i));
      return ageOk && genderOk && maritalOk && interestsOk;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final cards = _filtered;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              const Icon(Icons.filter_alt, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                'البحث المتقدم',
                style: GoogleFonts.tajawal(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ['ذكر', 'أنثى', 'طيف ذكر', 'طيف أنثى', 'آخر'].map((
                  g,
                ) {
                  final selected = _gender == g;
                  return ChoiceChip(
                    label: Text(g, style: GoogleFonts.tajawal()),
                    selected: selected,
                    onSelected: (_) => setState(() => _gender = g),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              Text('العمر', style: GoogleFonts.tajawal(color: Colors.white)),
              RangeSlider(
                values: _ageRange,
                labels: RangeLabels(
                  '${_ageRange.start.round()}',
                  '${_ageRange.end.round()}',
                ),
                min: 18,
                max: 80,
                divisions: 62,
                onChanged: (v) => setState(() => _ageRange = v),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ['أعزب', 'متزوج', 'منفصل', 'زوجان', 'كابل'].map((m) {
                  final selected = _marital == m;
                  return ChoiceChip(
                    label: Text(m, style: GoogleFonts.tajawal()),
                    selected: selected,
                    onSelected: (_) => setState(() => _marital = m),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    [
                      'تعارف',
                      'محادثة متعددة الوسائط',
                      'لقاء',
                      'شريك حياة',
                      'شريك سكن',
                      'ارتباط',
                      'زواج',
                    ].map((opt) {
                      final sel = _interests.contains(opt);
                      return FilterChip(
                        selected: sel,
                        label: Text(opt, style: GoogleFonts.tajawal()),
                        onSelected: (val) {
                          setState(() {
                            if (val) {
                              _interests.add(opt);
                            } else {
                              _interests.remove(opt);
                            }
                          });
                        },
                      );
                    }).toList(),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Stack(
                  children: cards.asMap().entries.map((entry) {
                    final idx = entry.key;
                    final user = entry.value;
                    return Positioned.fill(
                      top: idx.toDouble() * 6,
                      child: Dismissible(
                        key: ValueKey('card_$idx_${user['nickname']}'),
                        direction: DismissDirection.horizontal,
                        onDismissed: (d) {
                          setState(() {
                            _users.remove(user);
                          });
                        },
                        background: Container(
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.all(20),
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.green,
                          ),
                        ),
                        secondaryBackground: Container(
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.all(20),
                          child: const Icon(Icons.close, color: Colors.red),
                        ),
                        child: UserCard(
                          nickname: user['nickname'],
                          age: user['age'],
                          country: AppSession.profile.country ?? 'غير محدد',
                          status: 'نتيجة مطابقة',
                          isVerified: true,
                          isGuest: AppSession.isGuest,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
