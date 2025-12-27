import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class PrivateChatScreen extends StatefulWidget {
  final String peerName;
  const PrivateChatScreen({super.key, required this.peerName});

  @override
  State<PrivateChatScreen> createState() => _PrivateChatScreenState();
}

class _PrivateChatScreenState extends State<PrivateChatScreen> {
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _peerTyping = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add({'text': text, 'isMe': true, 'read': false});
    });
    _controller.clear();
    Timer(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        final last = _messages.last;
        last['read'] = true;
      });
    });
  }

  Future<void> _sendSelfDestructImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1200,
      imageQuality: 85,
    );
    if (file == null) return;
    final bytes = await file.readAsBytes();
    final expiresAt = DateTime.now().add(const Duration(seconds: 10));
    setState(() {
      _messages.add({
        'image': bytes,
        'isMe': true,
        'read': false,
        'expiresAt': expiresAt,
      });
    });
    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        final last = _messages.last;
        last['read'] = true;
      });
    });
    Timer(const Duration(seconds: 10), () {
      if (!mounted) return;
      setState(() {
        _messages.removeWhere(
          (m) =>
              m['expiresAt'] != null && DateTime.now().isAfter(m['expiresAt']),
        );
      });
    });
  }

  void _onTyping(String v) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.lock, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              'محادثة خاصة مع ${widget.peerName}',
              style: GoogleFonts.tajawal(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
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
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF3F4F6), Color(0xFFE1E5EB)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            if (_peerTyping)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(
                  'يكتب...',
                  style: GoogleFonts.tajawal(color: Colors.black54),
                ),
              ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  final isMe = msg['isMe'] == true;
                  return Align(
                    alignment: isMe
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isMe
                            ? const Color(0xFF7851A9).withValues(alpha: 0.85)
                            : Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.4),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          if (msg['image'] != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.memory(
                                msg['image'] as Uint8List,
                                width: 220,
                                height: 160,
                                fit: BoxFit.cover,
                              ),
                            )
                          else
                            Text(
                              msg['text'] ?? '',
                              style: GoogleFonts.tajawal(
                                fontSize: 15,
                                color: isMe ? Colors.white : Colors.black87,
                              ),
                            ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                msg['read'] == true
                                    ? Icons.done_all
                                    : Icons.done,
                                size: 16,
                                color: Colors.white70,
                              ),
                              if (msg['expiresAt'] != null)
                                Padding(
                                  padding: const EdgeInsets.only(left: 6),
                                  child: Text(
                                    'يحذف تلقائياً',
                                    style: GoogleFonts.tajawal(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onChanged: _onTyping,
                      style: GoogleFonts.tajawal(fontSize: 16),
                      decoration: InputDecoration(
                        hintText: 'اكتب رسالة...',
                        hintStyle: GoogleFonts.tajawal(
                          color: Colors.grey.shade500,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
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
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: _sendSelfDestructImage,
                    icon: const Icon(Icons.camera),
                    color: const Color(0xFF191970),
                  ),
                  ElevatedButton(
                    onPressed: _send,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF191970),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    child: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
