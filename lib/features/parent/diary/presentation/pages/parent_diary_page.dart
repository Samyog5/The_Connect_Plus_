import 'package:flutter/material.dart';

import 'package:tcp/features/parent/widgets/parent_placeholder_page.dart';

class ParentDiaryPage extends StatelessWidget {
  final String userName;
  final String userAvatar;

  const ParentDiaryPage({
    super.key,
    required this.userName,
    required this.userAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return ParentPlaceholderPage(
      title: 'Diary',
      userName: userName,
      userAvatar: userAvatar,
    );
  }
}
