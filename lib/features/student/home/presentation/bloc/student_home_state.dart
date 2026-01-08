part of 'student_home_bloc.dart';

abstract class StudentHomeState extends Equatable {
  const StudentHomeState();

  @override
  List<Object> get props => [];
}

class StudentHomeInitial extends StudentHomeState {}

class StudentHomeLoading extends StudentHomeState {}

class StudentHomeLoaded extends StudentHomeState {
  final List<Map<String, String>> notices;
  final List<Map<String, String>> assignments;
  final List<Map<String, String>> routine;
  final Map<String, String> fees;

  const StudentHomeLoaded({
    required this.notices,
    required this.assignments,
    required this.routine,
    required this.fees,
  });

  @override
  List<Object> get props => [notices, assignments, routine, fees];
}

class StudentHomeError extends StudentHomeState {
  final String message;

  const StudentHomeError({required this.message});

  @override
  List<Object> get props => [message];
}
