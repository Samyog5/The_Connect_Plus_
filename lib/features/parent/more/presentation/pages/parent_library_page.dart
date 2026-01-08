import 'package:flutter/material.dart';

import 'package:tcp/features/parent/widgets/parent_placeholder_page.dart';

class ParentLibraryPage extends StatelessWidget {
  final String userName;
  final String userAvatar;

  const ParentLibraryPage({
    super.key,
    required this.userName,
    required this.userAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return ParentPlaceholderPage(
      title: 'Library',
      userName: userName,
      userAvatar: userAvatar,
    );
  }
}
