import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wesal_app/models/session.dart';

class MailboxScreen extends StatelessWidget {
  const MailboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final requests = [
      {'from': 'سارة', 'preview': 'طلب محادثة خاصة'},
      {'from': 'عمر', 'preview': 'يريد الوصول للألبوم'},
    ];
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: requests.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (ctx, i) {
        final r = requests[i];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white24),
          ),
          child: Row(
            children: [
              const Icon(Icons.lock, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      r['from']!,
                      style: GoogleFonts.tajawal(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      r['preview']!,
                      style: GoogleFonts.tajawal(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: AppSession.isGuest ? null : () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7851A9),
                  foregroundColor: Colors.white,
                ),
                child: Text('عرض', style: GoogleFonts.tajawal()),
              ),
            ],
          ),
        );
      },
    );
  }
}
