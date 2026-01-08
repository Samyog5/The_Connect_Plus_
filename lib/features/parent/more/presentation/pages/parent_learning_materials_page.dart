import 'package:flutter/material.dart';

import 'package:tcp/features/parent/widgets/parent_placeholder_page.dart';

class ParentLearningMaterialsPage extends StatelessWidget {
  final String userName;
  final String userAvatar;

  const ParentLearningMaterialsPage({
    super.key,
    required this.userName,
    required this.userAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return ParentPlaceholderPage(
      title: 'Learning Materials',
      userName: userName,
      userAvatar: userAvatar,
    );
  }
}
