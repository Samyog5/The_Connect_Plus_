import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcp/features/parent/notices/domain/usecases/get_parent_notices.dart';
import 'package:tcp/features/parent/notices/presentation/bloc/parent_notices_event.dart';
import 'package:tcp/features/parent/notices/presentation/bloc/parent_notices_state.dart';

class ParentNoticesBloc extends Bloc<ParentNoticesEvent, ParentNoticesState> {
  final GetParentNotices getParentNotices;

  ParentNoticesBloc(this.getParentNotices) : super(const ParentNoticesInitial()) {
    on<LoadParentNotices>(_onLoad);
  }

  Future<void> _onLoad(
    LoadParentNotices event,
    Emitter<ParentNoticesState> emit,
  ) async {
    emit(const ParentNoticesLoading());
    try {
      final notices = await getParentNotices();
      emit(ParentNoticesLoaded(notices));
    } catch (_) {
      emit(const ParentNoticesError('Failed to load notices'));
    }
  }
}
