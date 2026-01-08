import 'package:flutter/material.dart';

import 'package:tcp/features/parent/widgets/parent_placeholder_page.dart';

class ParentExamManagementPage extends StatelessWidget {
  final String userName;
  final String userAvatar;

  const ParentExamManagementPage({
    super.key,
    required this.userName,
    required this.userAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return ParentPlaceholderPage(
      title: 'Exam Management',
      userName: userName,
      userAvatar: userAvatar,
    );
  }
}
