import 'package:equatable/equatable.dart';
import 'package:tcp/features/student/diary/assignment/domain/entities/assignment.dart';

abstract class AssignmentState extends Equatable {
  const AssignmentState();

  @override
  List<Object> get props => [];
}

class AssignmentInitial extends AssignmentState {}

class AssignmentLoading extends AssignmentState {}

class AssignmentLoaded extends AssignmentState {
  final List<Assignment> assignments;

  const AssignmentLoaded({required this.assignments});

  List<Assignment> get pendingAssignments =>
      assignments.where((a) => !a.isCompleted).toList();

  List<Assignment> get completedAssignments =>
      assignments.where((a) => a.isCompleted).toList();

  double get completionPercentage {
    if (assignments.isEmpty) return 0;
    return (completedAssignments.length / assignments.length) * 100;
  }

  @override
  List<Object> get props => [assignments];
}

class AssignmentError extends AssignmentState {
  final String message;

  const AssignmentError(this.message);

  @override
  List<Object> get props => [message];
}
