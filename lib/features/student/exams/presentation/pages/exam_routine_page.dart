import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:tcp/features/student/exams/presentation/bloc/exam_bloc.dart';
import 'package:tcp/features/student/exams/presentation/bloc/exam_event.dart';
import 'package:tcp/features/student/exams/presentation/bloc/exam_state.dart';
import 'package:tcp/features/student/exams/presentation/widgets/exam_card.dart';
import 'package:tcp/injection_container.dart' as di;

class ExamRoutinePage extends StatelessWidget {
  const ExamRoutinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<ExamBloc>()..add(LoadExams()),
      child: const ExamRoutineView(),
    );
  }
}

class ExamRoutineView extends StatelessWidget {
  const ExamRoutineView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            sliver: BlocBuilder<ExamBloc, ExamState>(
              builder: (context, state) {
                if (state is ExamLoading) {
                  return _buildLoading();
                }

                if (state is ExamError) {
                  return _buildError(context, state.message);
                }

                if (state is ExamLoaded && state.exams.isEmpty) {
                  return _buildEmptyState();
                }

                if (state is ExamLoaded) {
                  return _buildExamList(state);
                }

                return const SliverToBoxAdapter();
              },
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
      floating: false,
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Exam Routine',
        style: TextStyle(
          color: Color(0xFF0F172A),
          fontWeight: FontWeight.w800,
          fontSize: 22,
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
  // LOADING SKELETON
  // ================================
  SliverList _buildLoading() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => _SkeletonCard()
            .animate()
            .fadeIn(duration: 300.ms)
            .shimmer(duration: 1200.ms),
        childCount: 5,
      ),
    );
  }

  // ================================
  // EXAM LIST
  // ================================
  SliverList _buildExamList(ExamLoaded state) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return ExamCard(exam: state.exams[index])
            .animate(delay: (80 * index).ms)
            .fadeIn(duration: 450.ms)
            .slideY(begin: 0.08, curve: Curves.easeOutCubic);
      }, childCount: state.exams.length),
    );
  }

  // ================================
  // EMPTY STATE
  // ================================
  SliverToBoxAdapter _buildEmptyState() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Column(
          children: [
            Icon(
              Icons.event_available_rounded,
              size: 80,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 20),
            const Text(
              'No exams scheduled',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF334155),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your upcoming exams will appear here',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }

  // ================================
  // ERROR STATE
  // ================================
  SliverToBoxAdapter _buildError(BuildContext context, String message) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Column(
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 72,
              color: Colors.red.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, color: Color(0xFF475569)),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => context.read<ExamBloc>().add(LoadExams()),
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================================
// SKELETON CARD
// ================================
class _SkeletonCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(18),
      ),
    );
  }
}
