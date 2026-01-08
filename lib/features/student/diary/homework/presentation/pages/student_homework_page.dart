import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

/* ===================== MODEL ===================== */

class Homework {
  final String id;
  final String subject;
  final String title;
  final String remarks;
  final DateTime date;
  final String nepaliDate;

  Homework({
    required this.id,
    required this.subject,
    required this.title,
    required this.remarks,
    required this.date,
    required this.nepaliDate,
  });
}

/* ===================== MOCK DATA ===================== */

final List<Homework> sampleHomeworks = [
  Homework(
    id: '1',
    subject: 'Mathematics',
    title: 'Complete exercise 5.1',
    remarks: 'Submit tomorrow',
    date: DateTime(2025, 12, 17),
    nepaliDate: 'Poush 02, 2082',
  ),
  Homework(
    id: '2',
    subject: 'English',
    title: 'Write essay on pollution',
    remarks: 'Minimum 300 words',
    date: DateTime(2025, 12, 17),
    nepaliDate: 'Poush 02, 2082',
  ),
];

/* ===================== PAGE ===================== */

class StudentHomeworkPage extends StatelessWidget {
  const StudentHomeworkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedDate = DateTime(2025, 12, 17);

    final homeworks = sampleHomeworks
        .where((h) => DateUtils.isSameDay(h.date, selectedDate))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Homework',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DateHeader(
              date: selectedDate,
              nepaliDate: homeworks.isNotEmpty
                  ? homeworks.first.nepaliDate
                  : '',
            ),
            const SizedBox(height: 24),
            Expanded(
              child: homeworks.isEmpty
                  ? const EmptyHomework()
                  : ListView.builder(
                      itemCount: homeworks.length,
                      itemBuilder: (context, index) {
                        return HomeworkCard(
                          homework: homeworks[index],
                        ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ===================== DATE HEADER ===================== */

class _DateHeader extends StatelessWidget {
  final DateTime date;
  final String nepaliDate;

  const _DateHeader({required this.date, required this.nepaliDate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateFormat('EEEE, MMM d yyyy').format(date),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        if (nepaliDate.isNotEmpty)
          Text(nepaliDate, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

/* ===================== HOMEWORK CARD ===================== */

class HomeworkCard extends StatelessWidget {
  final Homework homework;

  const HomeworkCard({super.key, required this.homework});

  LinearGradient getGradient(String subject) {
    switch (subject.toLowerCase()) {
      case 'mathematics':
        return const LinearGradient(
          colors: [Color(0xFF60A5FA), Color(0xFF2563EB)],
        );
      case 'english':
        return const LinearGradient(
          colors: [Color(0xFFFBBF24), Color(0xFFD97706)],
        );
      default:
        return const LinearGradient(
          colors: [Color(0xFFA5B4FC), Color(0xFF6366F1)],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: getGradient(homework.subject),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.menu_book_rounded, color: Colors.white, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  homework.subject,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  homework.title,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  homework.remarks,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* ===================== EMPTY STATE ===================== */

class EmptyHomework extends StatelessWidget {
  const EmptyHomework({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.inbox_rounded, size: 72, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No homework for today 🎉',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
