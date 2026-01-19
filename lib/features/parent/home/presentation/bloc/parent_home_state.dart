import 'package:equatable/equatable.dart';
import 'package:tcp/features/parent/home/domain/entities/parent_home_dashboard.dart';

abstract class ParentHomeState extends Equatable {
  const ParentHomeState();

  @override
  List<Object?> get props => [];
}

class ParentHomeInitial extends ParentHomeState {
  const ParentHomeInitial();
}

class ParentHomeLoading extends ParentHomeState {
  const ParentHomeLoading();
}

class ParentHomeLoaded extends ParentHomeState {
  final ParentHomeDashboard dashboard;

  const ParentHomeLoaded(this.dashboard);

  @override
  List<Object?> get props => [dashboard];
}

class ParentHomeError extends ParentHomeState {
  final String message;

  const ParentHomeError(this.message);

  @override
  List<Object?> get props => [message];
}
