import 'package:flutter/material.dart';

import 'package:tcp/features/parent/widgets/parent_placeholder_page.dart';

class ParentEducationalNewsPage extends StatelessWidget {
  final String userName;
  final String userAvatar;

  const ParentEducationalNewsPage({
    super.key,
    required this.userName,
    required this.userAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return ParentPlaceholderPage(
      title: 'Educational News',
      userName: userName,
      userAvatar: userAvatar,
    );
  }
}
