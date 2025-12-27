import 'package:flutter/material.dart';

class WesalLogo extends StatelessWidget {
  final double size;
  final bool isLight;

  const WesalLogo({super.key, this.size = 100, this.isLight = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // The Chat Bubble
        Icon(
          Icons.chat_bubble,
          size: size,
          color: isLight ? Colors.white : const Color(0xFF7851A9),
        ),
        // The Lock symbol inside
        Positioned(
          top: size * 0.25,
          child: Icon(
            Icons.lock,
            size: size * 0.45,
            color: isLight ? const Color(0xFF7851A9) : Colors.white,
          ),
        ),
      ],
    );
  }
}
