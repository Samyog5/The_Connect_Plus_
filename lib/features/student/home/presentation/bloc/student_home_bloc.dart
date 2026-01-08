import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'student_home_event.dart';
part 'student_home_state.dart';

class StudentHomeBloc extends Bloc<StudentHomeEvent, StudentHomeState> {
  StudentHomeBloc() : super(StudentHomeInitial()) {
    on<LoadStudentHome>((event, emit) async {
      emit(StudentHomeLoading());

      try {
        // Simulate fetching data from API or repository
        await Future.delayed(const Duration(seconds: 1));

        final notices = [
          {
            'title': 'Winter Vacation Announcement',
            'description': 'School closed Jan 15-25. Classes resume Jan 27.',
            'time': '2 hours ago',
          },
          {
            'title': 'Exam Schedule Released',
            'description': 'Final exams from March 1st to March 15th.',
            'time': '1 day ago',
          },
        ];

        final assignments = [
          {
            'title': 'Mathematics Assignment',
            'subject': 'Mathematics',
            'description': 'Complete chapter 5 exercises',
            'dueDate': 'Jan 10, 2026',
            'status': 'Pending',
          },
          {
            'title': 'English Essay',
            'subject': 'English',
            'description': 'Write an essay on "Technology and Society"',
            'dueDate': 'Jan 12, 2026',
            'status': 'In Progress',
          },
          {
            'title': 'Science Project',
            'subject': 'Science',
            'description': 'Create a model of solar system',
            'dueDate': 'Jan 15, 2026',
            'status': 'Pending',
          },
        ];

        final routine = [
          {
            'time': '09:00 AM',
            'subject': 'Mathematics',
            'teacher': 'Mr. Sharma',
          },
          {'time': '10:00 AM', 'subject': 'Science', 'teacher': 'Ms. Pradhan'},
          {'time': '11:30 AM', 'subject': 'English', 'teacher': 'Mrs. Karki'},
        ];

        final fees = {'totalDue': 'Rs. 4,500.00', 'dueDate': 'Jan 15, 2026'};

        emit(
          StudentHomeLoaded(
            notices: notices,
            assignments: assignments,
            routine: routine,
            fees: fees,
          ),
        );
      } catch (e) {
        emit(StudentHomeError(message: e.toString()));
      }
    });
  }
}
