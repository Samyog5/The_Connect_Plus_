import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tcp/features/student/exams/presentation/widgets/online_exam_card.dart';

class OnlineExamPage extends StatelessWidget {
  const OnlineExamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF0F172A),
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: const Text(
            'Online Exam',
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: Container(
              height: 46,
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(14),
              ),
              child: TabBar(
                splashBorderRadius: BorderRadius.circular(14),
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                labelColor: const Color(0xFF0F172A),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
                unselectedLabelColor: const Color(0xFF64748B),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                padding: const EdgeInsets.all(4),
                tabs: const [
                  Tab(text: 'Live'),
                  Tab(text: 'Upcoming'),
                  Tab(text: 'Completed'),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _buildLiveExams(),
            _buildUpcomingExams(),
            _buildCompletedExams(),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveExams() {
    // Mock Data
    final exams = [
      {
        'subject': 'Mathematics Final',
        'date': 'Today',
        'time': '10:00 AM',
        'duration': '2 Hours',
        'marks': 100,
      },
    ];

    if (exams.isEmpty) return _buildEmptyState('No live exams at the moment');

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: exams.length,
      itemBuilder: (context, index) {
        final exam = exams[index];
        return OnlineExamCard(
          subject: exam['subject'] as String,
          date: exam['date'] as String,
          time: exam['time'] as String,
          duration: exam['duration'] as String,
          totalMarks: exam['marks'] as int,
          status: ExamStatus.live,
          onTap: () {},
        ).animate().fadeIn().slideY(begin: 0.1);
      },
    );
  }

  Widget _buildUpcomingExams() {
    final exams = [
      {
        'subject': 'Science - Physics',
        'date': 'Tomorrow',
        'time': '10:00 AM',
        'duration': '1.5 Hours',
        'marks': 50,
      },
      {
        'subject': 'English Grammar',
        'date': '15 Jan 2026',
        'time': '11:00 AM',
        'duration': '1 Hour',
        'marks': 40,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: exams.length,
      itemBuilder: (context, index) {
        final exam = exams[index];
        return OnlineExamCard(
          subject: exam['subject'] as String,
          date: exam['date'] as String,
          time: exam['time'] as String,
          duration: exam['duration'] as String,
          totalMarks: exam['marks'] as int,
          status: ExamStatus.upcoming,
          onTap: () {},
        ).animate(delay: (100 * index).ms).fadeIn().slideY(begin: 0.1);
      },
    );
  }

  Widget _buildCompletedExams() {
    final exams = [
      {
        'subject': 'History - World War II',
        'date': 'Yesterday',
        'time': '02:00 PM',
        'duration': '1 Hour',
        'marks': 50,
        'obtained': 42,
      },
      {
        'subject': 'Geography - Maps',
        'date': '10 Jan 2026',
        'time': '10:00 AM',
        'duration': '45 Mins',
        'marks': 30,
        'obtained': 28,
      },
      {
        'subject': 'Computer Science',
        'date': '08 Jan 2026',
        'time': '11:30 AM',
        'duration': '1 Hour',
        'marks': 50,
        'obtained': 45,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: exams.length,
      itemBuilder: (context, index) {
        final exam = exams[index];
        return OnlineExamCard(
          subject: exam['subject'] as String,
          date: exam['date'] as String,
          time: exam['time'] as String,
          duration: exam['duration'] as String,
          totalMarks: exam['marks'] as int,
          obtainedMarks: exam['obtained'] as int,
          status: ExamStatus.completed,
          onTap: () {},
        ).animate(delay: (100 * index).ms).fadeIn().slideY(begin: 0.1);
      },
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_busy_rounded, size: 60, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
