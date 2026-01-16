import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NewsNewsletterSection extends StatelessWidget {
  final VoidCallback onSubscribe;
  final VoidCallback onViewPastIssues;

  const NewsNewsletterSection({
    super.key,
    required this.onSubscribe,
    required this.onViewPastIssues,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFEF4444).withOpacity(0.08),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, const Color(0xFFEF4444).withOpacity(0.03)],
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF2F2), // Red 50
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFEF4444).withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.mark_email_unread_rounded,
              color: Color(0xFFEF4444),
              size: 32,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Stay Ahead of the Curve',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1E293B),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Weekly digests of the most important developments in global and local education, curated just for you.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF64748B),
              height: 1.6,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: onSubscribe,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444),
                elevation: 0,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'SUBSCRIBE TO DIGEST',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: onViewPastIssues,
            child: const Text(
              'VIEW PAST ISSUES',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: Color(0xFF94A3B8),
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    ).animate(delay: 400.ms).fadeIn(duration: 800.ms).slideY(begin: 0.1, end: 0);
  }
}
