import 'package:equatable/equatable.dart';

abstract class ParentNoticesEvent extends Equatable {
  const ParentNoticesEvent();

  @override
  List<Object?> get props => [];
}

class LoadParentNotices extends ParentNoticesEvent {
  const LoadParentNotices();
}
