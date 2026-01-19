import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tcp/injection_container.dart' as di;
import 'package:tcp/features/parent/diary/domain/entities/parent_diary_destination.dart';
import 'package:tcp/features/parent/diary/presentation/bloc/parent_diary_bloc.dart';
import 'package:tcp/features/parent/diary/presentation/bloc/parent_diary_event.dart';
import 'package:tcp/features/parent/diary/presentation/bloc/parent_diary_state.dart';
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
    return BlocProvider(
      create: (_) => di.sl<ParentDiaryBloc>()..add(const LoadParentDiaryMenu()),
      child: BlocBuilder<ParentDiaryBloc, ParentDiaryState>(
        builder: (context, state) {
          if (state is ParentDiaryLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state is ParentDiaryLoaded) {
            return Scaffold(
              appBar: AppBar(title: const Text('Diary')),
              body: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  return ListTile(
                    leading: Icon(_iconFor(item.destination)),
                    title: Text(item.label),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _handleTap(context, item.destination),
                  );
                },
              ),
            );
          }

          if (state is ParentDiaryError) {
            return Scaffold(
              appBar: AppBar(title: const Text('Diary')),
              body: Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return ParentPlaceholderPage(
            title: 'Diary',
            userName: userName,
            userAvatar: userAvatar,
          );
        },
      ),
    );
  }

  static IconData _iconFor(ParentDiaryDestination destination) {
    switch (destination) {
      case ParentDiaryDestination.homework:
        return Icons.menu_book;
      case ParentDiaryDestination.calendar:
        return Icons.calendar_month;
      case ParentDiaryDestination.assignments:
        return Icons.assignment;
    }
  }

  void _handleTap(BuildContext context, ParentDiaryDestination destination) {
    final label = switch (destination) {
      ParentDiaryDestination.homework => 'Homework',
      ParentDiaryDestination.calendar => 'Calendar',
      ParentDiaryDestination.assignments => 'Assignments',
    };

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ParentPlaceholderPage(
          title: label,
          userName: userName,
          userAvatar: userAvatar,
        ),
      ),
    );
  }
}
