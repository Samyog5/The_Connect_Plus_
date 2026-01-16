import 'package:bloc/bloc.dart';
import '../../domain/entities/notice.dart';
import '../../domain/usecases/get_notices.dart';
import 'notices_event.dart';
import 'notices_state.dart';

class NoticesBloc extends Bloc<NoticesEvent, NoticesState> {
  final GetNotices getNotices;

  NoticesBloc({required this.getNotices}) : super(NoticesInitial()) {
    on<LoadNotices>(_onLoadNotices);
    on<FilterNoticesByCategory>(_onFilterNoticesByCategory);
    on<MarkNoticeAsRead>(_onMarkNoticeAsRead);
  }

  Future<void> _onLoadNotices(
    LoadNotices event,
    Emitter<NoticesState> emit,
  ) async {
    emit(NoticesLoading());
    try {
      final notices = await getNotices();
      emit(NoticesLoaded(notices: notices));
    } catch (e) {
      emit(NoticesError(e.toString()));
    }
  }

  void _onFilterNoticesByCategory(
    FilterNoticesByCategory event,
    Emitter<NoticesState> emit,
  ) {
    if (state is NoticesLoaded) {
      final currentState = state as NoticesLoaded;
      emit(currentState.copyWith(selectedCategory: event.category));
    }
  }

  void _onMarkNoticeAsRead(MarkNoticeAsRead event, Emitter<NoticesState> emit) {
    if (state is NoticesLoaded) {
      final currentState = state as NoticesLoaded;
      final updatedNotices = currentState.notices.map((notice) {
        if (notice.id == event.noticeId) {
          return Notice(
            id: notice.id,
            type: notice.type,
            title: notice.title,
            description: notice.description,
            date: notice.date,
            author: notice.author,
            priority: notice.priority,
            isUnread: false,
          );
        }
        return notice;
      }).toList();
      emit(currentState.copyWith(notices: updatedNotices));
    }
  }
}
