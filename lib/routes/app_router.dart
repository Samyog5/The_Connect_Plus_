import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tcp/features/student/diary/assignment/presentation/pages/student_assignment_page.dart';
import 'package:tcp/features/student/diary/calendar/presentation/pages/student_calendar_page.dart';
import 'package:tcp/features/student/diary/presentation/pages/student_diary_page.dart';
import 'package:tcp/features/student/diary/homework/presentation/pages/student_homework_page.dart';
import 'package:tcp/features/student/home/presentation/pages/student_home_page.dart';
import 'package:tcp/features/student/more/presentation/pages/student_more_page.dart';
import 'package:tcp/features/student/notices/presentation/pages/student_notices_page.dart';
import 'package:tcp/features/student/schedule/presentation/pages/student_schedule_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) => const StudentHomePage(
          userName: 'John Doe',
          userRole: 'Student',
          userAvatar: 'assets/avatar.png',
        ),
      ),
      GoRoute(
        path: '/schedule',
        builder: (context, state) => const StudentSchedulePage(
          userName: 'John Doe',
          userAvatar: 'assets/avatar.png',
        ),
      ),
      GoRoute(
        path: '/notices',
        builder: (context, state) => const StudentNoticesPage(
          userName: 'John Doe',
          userAvatar: 'assets/avatar.png',
        ),
      ),
      GoRoute(
        path: '/more',
        builder: (context, state) => const StudentMorePage(
          userName: 'John Doe',
          userAvatar: 'assets/avatar.png',
        ),
      ),
      GoRoute(
        path: '/diary',
        builder: (context, state) => const StudentDiaryPage(
          userName: 'John Doe',
          userAvatar: 'assets/avatar.png',
        ),
      ),
      GoRoute(
        path: '/homework',
        builder: (context, state) => const StudentHomeworkPage(),
      ),
      GoRoute(
        path: '/calendar',
        builder: (context, state) => const StudentCalendarPage(),
      ),
      GoRoute(
        path: '/assignments',
        builder: (context, state) => StudentAssignmentPage(),
      ),
    ],
  );
}
