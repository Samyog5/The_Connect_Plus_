import 'package:equatable/equatable.dart';

abstract class NoticesEvent extends Equatable {
  const NoticesEvent();

  @override
  List<Object?> get props => [];
}

class LoadNotices extends NoticesEvent {}

class FilterNoticesByCategory extends NoticesEvent {
  final String category;

  const FilterNoticesByCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class MarkNoticeAsRead extends NoticesEvent {
  final String noticeId;

  const MarkNoticeAsRead(this.noticeId);

  @override
  List<Object?> get props => [noticeId];
}
