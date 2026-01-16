import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tcp/features/student/diary/presentation/widgets/date_header.dart';
import 'package:tcp/features/student/diary/presentation/widgets/diary_entry_card.dart';
import 'package:tcp/features/student/diary/presentation/widgets/diary_empty_state.dart';

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
            DateHeader(
              date: selectedDate,
              nepaliDate: homeworks.isNotEmpty
                  ? homeworks.first.nepaliDate
                  : '',
            ),
            const SizedBox(height: 24),
            Expanded(
              child: homeworks.isEmpty
                  ? const DiaryEmptyState(message: 'No homework for today 🎉')
                  : ListView.builder(
                      itemCount: homeworks.length,
                      itemBuilder: (context, index) {
                        final h = homeworks[index];
                        return DiaryEntryCard(
                          subject: h.subject,
                          title: h.title,
                          remarks: h.remarks,
                          isGradient: true,
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
