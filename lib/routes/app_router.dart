import 'package:go_router/go_router.dart';
import 'package:tcp/features/parent/attendance/presentation/pages/parent_attendance_page.dart';
import 'package:tcp/features/parent/diary/presentation/pages/parent_diary_page.dart';
import 'package:tcp/features/parent/home/presentation/pages/parent_home_page.dart';
import 'package:tcp/features/parent/more/presentation/pages/parent_more_page.dart';
import 'package:tcp/features/parent/notices/presentation/pages/parent_notices_page.dart';
import 'package:tcp/features/student/diary/assignment/presentation/pages/student_assignment_page.dart';
import 'package:tcp/features/student/diary/calendar/presentation/pages/student_calendar_page.dart';
import 'package:tcp/features/student/diary/presentation/pages/student_diary_page.dart';
import 'package:tcp/features/student/diary/homework/presentation/pages/student_homework_page.dart';
import 'package:tcp/features/student/home/presentation/pages/student_home_page.dart';
import 'package:tcp/features/student/more/presentation/pages/student_more_page.dart';
import 'package:tcp/features/student/notices/presentation/pages/student_notices_page.dart';
import 'package:tcp/features/student/schedule/presentation/pages/student_schedule_page.dart';
import 'package:tcp/features/student/diary/presentation/pages/student_diary_page.dart';
import 'package:tcp/features/student/diary/homework/presentation/pages/student_homework_page.dart';
import 'package:tcp/features/student/diary/calendar/presentation/pages/student_calendar_page.dart';
import 'package:tcp/features/student/diary/assignment/presentation/pages/student_assignment_page.dart';

import 'package:tcp/features/student/news/presentation/pages/news_page.dart';
import 'package:tcp/features/student/news/presentation/bloc/news_bloc.dart';
import 'package:tcp/features/student/news/presentation/bloc/news_event.dart';
import 'package:tcp/features/student/news/domain/usecases/get_news.dart';
import 'package:tcp/features/student/news/data/repositories/news_repository_impl.dart';

import 'package:tcp/features/student/library/presentation/pages/library_page.dart';

class AppRouter {
  static Map<String, dynamic> _extraMap(GoRouterState state) {
    final extra = state.extra;
    if (extra is Map) {
      return extra.map((key, value) => MapEntry(key.toString(), value));
    }
    return const <String, dynamic>{};
  }

  static String _stringExtra(
    GoRouterState state,
    String key,
    String fallback,
  ) {
    final extras = _extraMap(state);
    final value = extras[key];
    if (value is String && value.trim().isNotEmpty) return value;
    return fallback;
  }

  static final GoRouter router = GoRouter(
    initialLocation: '/parent/home',
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) {
          final userName = _stringExtra(state, 'userName', 'Samyog');
          final userAvatar = _stringExtra(state, 'userAvatar', 'assets/avatar.png');
          final userRole = _stringExtra(state, 'userRole', 'Student');

          return StudentHomePage(
            userName: userName,
            userRole: userRole,
            userAvatar: userAvatar,
          );
        },
      ),

      GoRoute(
        path: '/schedule',
        builder: (context, state) {
          final userName = _stringExtra(state, 'userName', 'John Doe');
          final userAvatar = _stringExtra(state, 'userAvatar', 'assets/avatar.png');
          return StudentSchedulePage(userName: userName, userAvatar: userAvatar);
        },
      ),

      GoRoute(
        path: '/notices',
        builder: (context, state) {
          final userName = _stringExtra(state, 'userName', 'John Doe');
          final userAvatar = _stringExtra(state, 'userAvatar', 'assets/avatar.png');
          return StudentNoticesPage(userName: userName, userAvatar: userAvatar);
        },
      ),

      GoRoute(
        path: '/more',
        builder: (context, state) {
          final userName = _stringExtra(state, 'userName', 'John Doe');
          final userAvatar = _stringExtra(state, 'userAvatar', 'assets/avatar.png');
          return StudentMorePage(userName: userName, userAvatar: userAvatar);
        },
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
      GoRoute(
        path: '/parent/home',
        builder: (context, state) {
          final userName = _stringExtra(state, 'userName', 'Samyog Budhathoki');
          final userAvatar = _stringExtra(state, 'userAvatar', '');
          return ParentHomePage(userName: userName, userAvatar: userAvatar);
        }
      ),
       GoRoute(
        path: '/parent/attendance',
        builder: (context, state) {
          final userName = _stringExtra(state, 'userName', 'John Doe');
          final userAvatar = _stringExtra(state, 'userAvatar', '');
          return ParentAttendancePage(userName: userName, userAvatar: userAvatar);
        },
      ),
      GoRoute(
        path: '/parent/notices',
        builder: (context, state) {
          final userName = _stringExtra(state, 'userName', 'John Doe');
          final userAvatar = _stringExtra(state, 'userAvatar', '');
          return ParentNoticesPage(userName: userName, userAvatar: userAvatar);
        },
      ),
      GoRoute(
        path: '/parent/more',
        builder: (context, state) {
          final userName = _stringExtra(state, 'userName', 'John Doe');
          final userAvatar = _stringExtra(state, 'userAvatar', '');
          return ParentMorePage(userName: userName, userAvatar: userAvatar);
        },
      ),
      GoRoute(
        path: '/parent/diary',
        builder: (context, state) {
          final userName = _stringExtra(state, 'userName', 'Samyog');
          final userAvatar = _stringExtra(state, 'userAvatar', '');
          return ParentDiaryPage(userName: userName, userAvatar: userAvatar);
        },
      )
    ],
  );
}
