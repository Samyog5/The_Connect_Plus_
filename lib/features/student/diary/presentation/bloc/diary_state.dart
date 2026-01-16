import 'package:equatable/equatable.dart';
import '../../domain/entities/diary_item.dart';

abstract class DiaryState extends Equatable {
  const DiaryState();

  @override
  List<Object?> get props => [];
}

class DiaryInitial extends DiaryState {}

class DiaryLoading extends DiaryState {}

class DiaryLoaded extends DiaryState {
  final List<DiaryItem> items;
  final String selectedType;

  const DiaryLoaded({required this.items, this.selectedType = 'all'});

  List<DiaryItem> get filteredItems {
    if (selectedType == 'all') return items;
    return items.where((item) => item.type == selectedType).toList();
  }

  DiaryLoaded copyWith({List<DiaryItem>? items, String? selectedType}) {
    return DiaryLoaded(
      items: items ?? this.items,
      selectedType: selectedType ?? this.selectedType,
    );
  }

  @override
  List<Object?> get props => [items, selectedType];
}

class DiaryError extends DiaryState {
  final String message;

  const DiaryError(this.message);

  @override
  List<Object?> get props => [message];
}
