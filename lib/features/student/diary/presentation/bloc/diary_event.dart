import 'package:equatable/equatable.dart';

abstract class DiaryEvent extends Equatable {
  const DiaryEvent();

  @override
  List<Object?> get props => [];
}

class LoadDiary extends DiaryEvent {}

class FilterDiaryByType extends DiaryEvent {
  final String type;

  const FilterDiaryByType(this.type);

  @override
  List<Object?> get props => [type];
}
