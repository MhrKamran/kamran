import 'package:flutter/material.dart';

/// [Stateless Widget] — Section header with icon and label.
/// Used across the app wherever a labelled section is needed.
/// Stateless because it only displays static text/icon with no mutable state.
class SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const SectionHeader({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF1A6B4A)),
        const SizedBox(width: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2D2D2D),
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}
