import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcp/features/parent/home/domain/usecases/get_parent_home_dashboard.dart';
import 'package:tcp/features/parent/home/presentation/bloc/parent_home_event.dart';
import 'package:tcp/features/parent/home/presentation/bloc/parent_home_state.dart';

class ParentHomeBloc extends Bloc<ParentHomeEvent, ParentHomeState> {
  final GetParentHomeDashboard getParentHomeDashboard;

  ParentHomeBloc(this.getParentHomeDashboard)
      : super(const ParentHomeInitial()) {
    on<LoadParentHome>(_onLoad);
  }

  Future<void> _onLoad(
    LoadParentHome event,
    Emitter<ParentHomeState> emit,
  ) async {
    emit(const ParentHomeLoading());

    try {
      final dashboard = await getParentHomeDashboard();
      emit(ParentHomeLoaded(dashboard));
    } catch (_) {
      emit(const ParentHomeError('Failed to load home data'));
    }
  }
}
