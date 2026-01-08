import 'package:flutter/material.dart';

import 'package:tcp/features/parent/widgets/parent_placeholder_page.dart';

class ParentInstituteInformationPage extends StatelessWidget {
  final String userName;
  final String userAvatar;

  const ParentInstituteInformationPage({
    super.key,
    required this.userName,
    required this.userAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return ParentPlaceholderPage(
      title: 'Institute Information',
      userName: userName,
      userAvatar: userAvatar,
    );
  }
}
