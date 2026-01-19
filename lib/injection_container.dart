import 'package:get_it/get_it.dart';
import 'package:tcp/features/student/exams/data/repositories/exam_repository_impl.dart';
import 'package:tcp/features/student/exams/domain/repositories/exam_repository.dart';
import 'package:tcp/features/student/exams/domain/usecases/get_exams.dart';
import 'package:tcp/features/student/exams/presentation/bloc/exam_bloc.dart';
import 'package:tcp/features/student/notices/data/datasources/notices_remote_data_source.dart';
import 'package:tcp/features/student/notices/data/repositories/notices_repository_impl.dart';
import 'package:tcp/features/student/notices/domain/repositories/notices_repository.dart';
import 'package:tcp/features/student/notices/domain/usecases/get_notices.dart';
import 'package:tcp/features/student/notices/presentation/bloc/notices_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Student Notices
  // Bloc
  sl.registerFactory(() => NoticesBloc(getNotices: sl()));
  // Use cases
  sl.registerLazySingleton(() => GetNotices(sl()));
  // Repository
  sl.registerLazySingleton<NoticesRepository>(
    () => NoticesRepositoryImpl(remoteDataSource: sl()),
  );
  // Data sources
  sl.registerLazySingleton<NoticesRemoteDataSource>(
    () => NoticesRemoteDataSourceImpl(),
  );

  //! Features - Student Exams
  // Bloc
  sl.registerFactory(() => ExamBloc(getExams: sl()));
  // Use cases
  sl.registerLazySingleton(() => GetExams(sl()));
  // Repository
  sl.registerLazySingleton<ExamRepository>(() => ExamRepositoryImpl());
}
