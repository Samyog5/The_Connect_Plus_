import 'package:flutter/material.dart';

import 'package:tcp/features/parent/widgets/parent_placeholder_page.dart';

class ParentHeadOfInstitutePage extends StatelessWidget {
  final String userName;
  final String userAvatar;

  const ParentHeadOfInstitutePage({
    super.key,
    required this.userName,
    required this.userAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return ParentPlaceholderPage(
      title: 'Head of Institute',
      userName: userName,
      userAvatar: userAvatar,
    );
  }
}
