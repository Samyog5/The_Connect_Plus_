part of 'student_home_bloc.dart';

abstract class StudentHomeEvent {
  const StudentHomeEvent();

  @override
  List<Object> get props => [];
}

class LoadStudentHome extends StudentHomeEvent {}
