import 'package:equatable/equatable.dart';

abstract class ParentDiaryEvent extends Equatable {
  const ParentDiaryEvent();

  @override
  List<Object?> get props => [];
}

class LoadParentDiaryMenu extends ParentDiaryEvent {
  const LoadParentDiaryMenu();
}
