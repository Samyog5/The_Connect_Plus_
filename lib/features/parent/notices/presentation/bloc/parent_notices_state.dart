import 'package:equatable/equatable.dart';
import 'package:tcp/features/parent/notices/domain/entities/parent_notice.dart';

abstract class ParentNoticesState extends Equatable {
  const ParentNoticesState();

  @override
  List<Object?> get props => [];
}

class ParentNoticesInitial extends ParentNoticesState {
  const ParentNoticesInitial();
}

class ParentNoticesLoading extends ParentNoticesState {
  const ParentNoticesLoading();
}

class ParentNoticesLoaded extends ParentNoticesState {
  final List<ParentNotice> notices;

  const ParentNoticesLoaded(this.notices);

  @override
  List<Object?> get props => [notices];
}

class ParentNoticesError extends ParentNoticesState {
  final String message;

  const ParentNoticesError(this.message);

  @override
  List<Object?> get props => [message];
}
