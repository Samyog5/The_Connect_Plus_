import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ExamSyllabusPage extends StatelessWidget {
  const ExamSyllabusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
              child:
                  Column(
                        children: [
                          _buildEmptyState(),
                          const SizedBox(height: 32),
                          _buildActions(context),
                        ],
                      )
                      .animate()
                      .fadeIn(duration: 500.ms)
                      .slideY(begin: 0.08, curve: Curves.easeOutCubic),
            ),
          ),
        ],
      ),
    );
  }

  // ================================
  // APP BAR
  // ================================
  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: const Text(
        'Exam Syllabus',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: Color(0xFF0F172A),
          letterSpacing: -.3,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(height: 1, color: Colors.grey.shade200),
      ),
      iconTheme: const IconThemeData(color: Color(0xFF0F172A)),
    );
  }

  // ================================
  // EMPTY STATE
  // ================================
  Widget _buildEmptyState() {
    return Column(
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.menu_book_rounded,
            size: 56,
            color: Colors.indigo.shade400,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Syllabus Not Published Yet',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Once your school uploads the syllabus,\n it will appear here.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade500,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  // ================================
  // ACTIONS
  // ================================
  Widget _buildActions(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.notifications_active_rounded),
          label: const Text('Notify Me When Available'),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            backgroundColor: const Color(0xFF4F46E5),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Back to Exams',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
