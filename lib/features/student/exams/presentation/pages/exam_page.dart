import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ExamPage extends StatelessWidget {
  const ExamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Exams',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.w800,
            fontSize: 22,
            letterSpacing: -.3,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF0F172A)),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
        children: const [
          _ExamMenuCard(
            index: 0,
            title: 'Exam Routine',
            icon: Icons.calendar_month_rounded,
            color: Color(0xFF3B82F6),
            route: '/exams/routine',
          ),
          _ExamMenuCard(
            index: 1,
            title: 'Exam Syllabus',
            icon: Icons.menu_book_rounded,
            color: Color(0xFF10B981),
            route: '/exams/syllabus',
          ),
          _ExamMenuCard(
            index: 2,
            title: 'Exam Marksheet',
            icon: Icons.grade_rounded,
            color: Color(0xFFF59E0B),
            route: '/exams/marksheet',
          ),
          _ExamMenuCard(
            index: 3,
            title: 'Internal Marks',
            icon: Icons.assessment_rounded,
            color: Color(0xFF8B5CF6),
            route: '/exams/internal-marks',
          ),
          _ExamMenuCard(
            index: 4,
            title: 'Online Exam',
            icon: Icons.computer_rounded,
            color: Color(0xFFEF4444),
            route: '/exams/online-exam',
          ),
        ],
      ),
    );
  }
}

class _ExamMenuCard extends StatelessWidget {
  final int index;
  final String title;
  final IconData icon;
  final Color color;
  final String route;

  const _ExamMenuCard({
    required this.index,
    required this.title,
    required this.icon,
    required this.color,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
          onTap: () => context.push(route),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Colors.white, Color(0xFFF9FAFB)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                // Accent bar
                Container(
                  width: 4,
                  height: 56,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 14),

                // Icon
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: color.withOpacity(.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, size: 26, color: color),
                ),

                const SizedBox(width: 16),

                // Title
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ),

                Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.grey.shade400,
                  size: 28,
                ),
              ],
            ),
          ),
        )
        .animate(delay: (80 * index).ms)
        .fadeIn(duration: 450.ms)
        .slideX(begin: -0.04, curve: Curves.easeOutCubic);
  }
}
