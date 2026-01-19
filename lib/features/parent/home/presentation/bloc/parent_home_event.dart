import 'package:equatable/equatable.dart';

abstract class ParentHomeEvent extends Equatable {
  const ParentHomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadParentHome extends ParentHomeEvent {
  const LoadParentHome();
}
