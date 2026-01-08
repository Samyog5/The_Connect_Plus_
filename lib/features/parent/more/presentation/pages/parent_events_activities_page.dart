import 'package:flutter/material.dart';

import 'package:tcp/features/parent/widgets/parent_placeholder_page.dart';

class ParentEventsActivitiesPage extends StatelessWidget {
  final String userName;
  final String userAvatar;

  const ParentEventsActivitiesPage({
    super.key,
    required this.userName,
    required this.userAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return ParentPlaceholderPage(
      title: 'Event & Activities',
      userName: userName,
      userAvatar: userAvatar,
    );
  }
}
