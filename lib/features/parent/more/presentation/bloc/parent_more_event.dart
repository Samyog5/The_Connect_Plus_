import 'package:equatable/equatable.dart';

abstract class ParentMoreEvent extends Equatable {
  const ParentMoreEvent();

  @override
  List<Object?> get props => [];
}

class LoadParentMoreMenu extends ParentMoreEvent {
  const LoadParentMoreMenu();
}
