import 'package:flutter/material.dart';

import 'package:tcp/features/parent/widgets/parent_placeholder_page.dart';

class ParentELearningPage extends StatelessWidget {
  final String userName;
  final String userAvatar;

  const ParentELearningPage({
    super.key,
    required this.userName,
    required this.userAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return ParentPlaceholderPage(
      title: 'e-Learning',
      userName: userName,
      userAvatar: userAvatar,
    );
  }
}
