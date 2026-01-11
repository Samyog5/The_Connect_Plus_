import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcp/features/student/elearning/presentation/bloc/elearning_bloc.dart';
import 'package:tcp/features/student/elearning/presentation/bloc/elearning_state.dart';
import 'package:tcp/features/student/elearning/presentation/bloc/elearning_event.dart';
import '../widgets/elearning_card.dart';

class ELearningPage extends StatelessWidget {
  const ELearningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('e-Learning Hub')),
      body: BlocBuilder<ELearningBloc, ELearningState>(
        builder: (context, state) {
          if (state is ELearningLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ELearningLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<ELearningBloc>().add(LoadELearning());
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: state.materials
                    .map((e) => ELearningCard(material: e))
                    .toList(),
              ),
            );
          }

          return const Center(child: Text('No Data'));
        },
      ),
    );
  }
}
