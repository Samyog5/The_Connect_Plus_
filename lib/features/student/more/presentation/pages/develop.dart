import 'package:flutter/material.dart';

class ParentExamManagementPage extends StatelessWidget {
  final String userName;
  final String userAvatar;

  const ParentExamManagementPage({
    super.key,
    required this.userName,
    required this.userAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return ParentPlaceholderPage(
      title: 'Exam Management',
      userName: userName,
      userAvatar: userAvatar,
    );
  }
}

class ParentPlaceholderPage extends StatelessWidget {
  final String title;
  final String userName;
  final String userAvatar;

  const ParentPlaceholderPage({
    super.key,
    required this.title,
    required this.userName,
    required this.userAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          '$title Page for $userName',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
