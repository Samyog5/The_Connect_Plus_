import 'package:flutter/material.dart';

import 'package:tcp/core/utils/avatar_image_provider.dart';
import 'package:tcp/features/parent/widgets/parent_gradient_app_bar.dart';

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
    final avatarProvider = avatarImageProvider(userAvatar);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: ParentGradientAppBar(title: title),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.construction_rounded, size: 56),
              const SizedBox(height: 12),
              Text(
                '$title coming soon',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Hi $userName — this section will be available soon.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[700]),
              ),
              const SizedBox(height: 16),
              CircleAvatar(radius: 28, backgroundImage: avatarProvider),
            ],
          ),
        ),
      ),
    );
  }
}
