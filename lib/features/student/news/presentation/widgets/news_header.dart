import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NewsHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const NewsHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1E293B),
            letterSpacing: -1,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.05, end: 0);
  }
}
