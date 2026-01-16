import 'package:equatable/equatable.dart';
import '../../domain/entities/notice.dart';

abstract class NoticesState extends Equatable {
  const NoticesState();

  @override
  List<Object?> get props => [];
}

class NoticesInitial extends NoticesState {}

class NoticesLoading extends NoticesState {}

class NoticesLoaded extends NoticesState {
  final List<Notice> notices;
  final String selectedCategory;

  const NoticesLoaded({required this.notices, this.selectedCategory = 'All'});

  List<Notice> get filteredNotices {
    if (selectedCategory == 'All') {
      return notices;
    }
    return notices.where((n) => n.type == selectedCategory).toList();
  }

  NoticesLoaded copyWith({List<Notice>? notices, String? selectedCategory}) {
    return NoticesLoaded(
      notices: notices ?? this.notices,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [notices, selectedCategory];
}

class NoticesError extends NoticesState {
  final String message;

  const NoticesError(this.message);

  @override
  List<Object?> get props => [message];
}
