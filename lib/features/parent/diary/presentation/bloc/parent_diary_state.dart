import 'package:equatable/equatable.dart';
import 'package:tcp/features/parent/diary/domain/entities/parent_diary_item.dart';

abstract class ParentDiaryState extends Equatable {
  const ParentDiaryState();

  @override
  List<Object?> get props => [];
}

class ParentDiaryInitial extends ParentDiaryState {
  const ParentDiaryInitial();
}

class ParentDiaryLoading extends ParentDiaryState {
  const ParentDiaryLoading();
}

class ParentDiaryLoaded extends ParentDiaryState {
  final List<ParentDiaryItem> items;

  const ParentDiaryLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class ParentDiaryError extends ParentDiaryState {
  final String message;

  const ParentDiaryError(this.message);

  @override
  List<Object?> get props => [message];
}
