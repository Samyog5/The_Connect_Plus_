import 'package:flutter/material.dart';

import 'package:tcp/features/parent/widgets/parent_placeholder_page.dart';

class ParentZoomClassPage extends StatelessWidget {
  final String userName;
  final String userAvatar;

  const ParentZoomClassPage({
    super.key,
    required this.userName,
    required this.userAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return ParentPlaceholderPage(
      title: 'Zoom Class',
      userName: userName,
      userAvatar: userAvatar,
    );
  }
}
