import 'package:flutter/material.dart';

import '../../../diary/presentation/pages/parent_diary_page.dart';
import '../pages/parent_educational_news_page.dart';
import '../pages/parent_elearning_page.dart';
import '../pages/parent_events_activities_page.dart';
import '../pages/parent_exam_management_page.dart';
import '../pages/parent_fee_management_page.dart';
import '../pages/parent_head_of_institute_page.dart';
import '../pages/parent_institute_information_page.dart';
import '../pages/parent_invitations_greetings_page.dart';
import '../pages/parent_learning_materials_page.dart';
import '../pages/parent_library_page.dart';
import '../pages/parent_others_page.dart';
import '../pages/parent_vehicle_management_page.dart';
import '../pages/parent_zoom_class_page.dart';

class ParentMoreMenuItem {
  final IconData icon;
  final String label;
  final void Function(BuildContext context) onTap;

  const ParentMoreMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}

List<ParentMoreMenuItem> buildParentMoreMenuItems({
  required BuildContext context,
  required String userName,
  required String userAvatar,
  required void Function(int index) onBottomNavTap,
}) {
  void openPage(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  return [
    ParentMoreMenuItem(
      icon: Icons.star_rounded,
      label: 'Head of Institute',
      onTap: (ctx) => openPage(
        ParentHeadOfInstitutePage(userName: userName, userAvatar: userAvatar),
      ),
    ),
    ParentMoreMenuItem(
      icon: Icons.notifications_rounded,
      label: 'Notices',
      onTap: (_) => onBottomNavTap(2),
    ),
    ParentMoreMenuItem(
      icon: Icons.check_circle_outline_rounded,
      label: 'Attendance',
      onTap: (_) => onBottomNavTap(1),
    ),
    ParentMoreMenuItem(
      icon: Icons.book_rounded,
      label: 'Diary',
      onTap: (ctx) => openPage(
        ParentDiaryPage(userName: userName, userAvatar: userAvatar),
      ),
    ),
    ParentMoreMenuItem(
      icon: Icons.event_available_rounded,
      label: 'Event & Activities',
      onTap: (ctx) => openPage(
        ParentEventsActivitiesPage(userName: userName, userAvatar: userAvatar),
      ),
    ),
    ParentMoreMenuItem(
      icon: Icons.payments_rounded,
      label: 'Fee Management',
      onTap: (ctx) => openPage(
        ParentFeeManagementPage(userName: userName, userAvatar: userAvatar),
      ),
    ),
    ParentMoreMenuItem(
      icon: Icons.fact_check_rounded,
      label: 'Exam Management',
      onTap: (ctx) => openPage(
        ParentExamManagementPage(userName: userName, userAvatar: userAvatar),
      ),
    ),
    ParentMoreMenuItem(
      icon: Icons.local_library_rounded,
      label: 'Library',
      onTap: (ctx) => openPage(
        ParentLibraryPage(userName: userName, userAvatar: userAvatar),
      ),
    ),
    ParentMoreMenuItem(
      icon: Icons.menu_book_rounded,
      label: 'Learning Materials',
      onTap: (ctx) => openPage(
        ParentLearningMaterialsPage(userName: userName, userAvatar: userAvatar),
      ),
    ),
    ParentMoreMenuItem(
      icon: Icons.directions_bus_rounded,
      label: 'Vehicle Management',
      onTap: (ctx) => openPage(
        ParentVehicleManagementPage(userName: userName, userAvatar: userAvatar),
      ),
    ),
    ParentMoreMenuItem(
      icon: Icons.apartment_rounded,
      label: 'Institute Information',
      onTap: (ctx) => openPage(
        ParentInstituteInformationPage(userName: userName, userAvatar: userAvatar),
      ),
    ),
    ParentMoreMenuItem(
      icon: Icons.mail_rounded,
      label: 'Invitation / Greetings',
      onTap: (ctx) => openPage(
        ParentInvitationsGreetingsPage(userName: userName, userAvatar: userAvatar),
      ),
    ),
    ParentMoreMenuItem(
      icon: Icons.newspaper_rounded,
      label: 'Educational News',
      onTap: (ctx) => openPage(
        ParentEducationalNewsPage(userName: userName, userAvatar: userAvatar),
      ),
    ),
    ParentMoreMenuItem(
      icon: Icons.video_call_rounded,
      label: 'Zoom Class',
      onTap: (ctx) => openPage(
        ParentZoomClassPage(userName: userName, userAvatar: userAvatar),
      ),
    ),
    ParentMoreMenuItem(
      icon: Icons.school_rounded,
      label: 'e-Learning',
      onTap: (ctx) => openPage(
        ParentELearningPage(userName: userName, userAvatar: userAvatar),
      ),
    ),
    ParentMoreMenuItem(
      icon: Icons.more_horiz_rounded,
      label: 'Others',
      onTap: (ctx) => openPage(
        ParentOthersPage(userName: userName, userAvatar: userAvatar),
      ),
    ),
  ];
}
