import 'package:flutter/material.dart';

enum PrivacyState { visible, hidden, busy }

class PrivacyItemTile extends StatelessWidget {
  final String label;
  final PrivacyState currentState;
  final Function(PrivacyState) onStateChanged;
  final IconData? icon;

  const PrivacyItemTile({
    super.key,
    required this.label,
    required this.currentState,
    required this.onStateChanged,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, color: const Color(0xFF7851A9)),
                  const SizedBox(width: 8),
                ],
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildOption(
                  context,
                  PrivacyState.visible,
                  'مرئي',
                  Icons.visibility,
                ),
                _buildOption(
                  context,
                  PrivacyState.hidden,
                  'مخفي',
                  Icons.visibility_off,
                ),
                _buildOption(
                  context,
                  PrivacyState.busy,
                  'مشغول',
                  Icons.hourglass_empty,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(
    BuildContext context,
    PrivacyState state,
    String text,
    IconData icon,
  ) {
    final isSelected = currentState == state;
    final color = isSelected ? const Color(0xFF7851A9) : Colors.grey;

    return InkWell(
      onTap: () => onStateChanged(state),
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF7851A9).withOpacity(0.1)
              : Colors.transparent,
          border: Border.all(
            color: isSelected ? const Color(0xFF7851A9) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 4),
            Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
