import 'package:flutter/material.dart';

import 'package:tcp/features/parent/widgets/parent_placeholder_page.dart';

class ParentFeeManagementPage extends StatelessWidget {
  final String userName;
  final String userAvatar;

  const ParentFeeManagementPage({
    super.key,
    required this.userName,
    required this.userAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return ParentPlaceholderPage(
      title: 'Fee Management',
      userName: userName,
      userAvatar: userAvatar,
    );
  }
}
