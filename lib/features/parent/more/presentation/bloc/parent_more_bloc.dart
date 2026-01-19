import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcp/features/parent/more/domain/usecases/get_parent_more_menu.dart';
import 'package:tcp/features/parent/more/presentation/bloc/parent_more_event.dart';
import 'package:tcp/features/parent/more/presentation/bloc/parent_more_state.dart';

class ParentMoreBloc extends Bloc<ParentMoreEvent, ParentMoreState> {
  final GetParentMoreMenu getParentMoreMenu;

  ParentMoreBloc(this.getParentMoreMenu) : super(const ParentMoreInitial()) {
    on<LoadParentMoreMenu>(_onLoad);
  }

  Future<void> _onLoad(
    LoadParentMoreMenu event,
    Emitter<ParentMoreState> emit,
  ) async {
    emit(const ParentMoreLoading());

    try {
      final items = await getParentMoreMenu();
      emit(ParentMoreLoaded(items));
    } catch (_) {
      emit(const ParentMoreError('Failed to load menu'));
    }
  }
}
