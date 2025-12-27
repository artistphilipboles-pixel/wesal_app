import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wesal_app/models/session.dart';

class PublicChatScreen extends StatefulWidget {
  const PublicChatScreen({super.key});

  @override
  State<PublicChatScreen> createState() => _PublicChatScreenState();
}

class _PublicChatScreenState extends State<PublicChatScreen> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  late final String _roomTitle;
  Timer? _mockTimer;
  bool _someoneTyping = false;

  @override
  void initState() {
    super.initState();
    _roomTitle = AppSession.profile.country != null
        ? 'غرفة ${AppSession.profile.country} العامة'
        : 'غرفة عامة';
    _mockTimer = Timer.periodic(const Duration(seconds: 8), (t) {
      if (!mounted) return;
      setState(() {
        _messages.add({'user': 'نظام', 'text': 'مرحباً بكم في $_roomTitle'});
      });
    });
    Timer.periodic(const Duration(seconds: 6), (t) {
      if (!mounted) return;
      setState(() {
        _someoneTyping = !_someoneTyping;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _mockTimer?.cancel();
    super.dispose();
  }

  void _sendMessage() {
    final txt = _controller.text.trim();
    if (txt.isEmpty) return;
    setState(() {
      _messages.add({
        'user': AppSession.profile.nickname ?? 'أنا',
        'text': txt,
      });
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            _roomTitle,
            style: GoogleFonts.tajawal(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            reverse: true,
            itemCount: _messages.length,
            itemBuilder: (ctx, i) {
              final m = _messages[_messages.length - 1 - i];
              final me = m['user'] == (AppSession.profile.nickname ?? 'أنا');
              return Align(
                alignment: me ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: me
                        ? const Color(0xFF7851A9).withValues(alpha: 0.15)
                        : Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Column(
                    crossAxisAlignment: me
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        m['user']!,
                        style: GoogleFonts.tajawal(color: Colors.white70),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        m['text']!,
                        style: GoogleFonts.tajawal(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        if (_someoneTyping)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              'هناك من يكتب...',
              style: GoogleFonts.tajawal(color: Colors.white70, fontSize: 12),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  style: GoogleFonts.tajawal(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'اكتب رسالة...',
                    hintStyle: GoogleFonts.tajawal(color: Colors.white54),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                        color: Color(0xFF7851A9),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: AppSession.isGuest ? null : _sendMessage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7851A9),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Icon(Icons.send),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
