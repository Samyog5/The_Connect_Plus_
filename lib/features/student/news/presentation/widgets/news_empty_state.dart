import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NewsEmptyState extends StatelessWidget {
  const NewsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Icon(
              Icons.search_off_rounded,
              color: Colors.grey.shade300,
              size: 48,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'NO NEWS FOUND',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: Colors.grey.shade400,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your filters or search terms',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }
}
