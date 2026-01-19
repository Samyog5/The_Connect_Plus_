import 'package:bloc/bloc.dart';
import 'package:tcp/features/parent/diary/domain/usecases/get_parent_diary_menu.dart';
import 'package:tcp/features/parent/diary/presentation/bloc/parent_diary_event.dart';
import 'package:tcp/features/parent/diary/presentation/bloc/parent_diary_state.dart';

class ParentDiaryBloc extends Bloc<ParentDiaryEvent, ParentDiaryState> {
  final GetParentDiaryMenu getParentDiaryMenu;

  ParentDiaryBloc({required this.getParentDiaryMenu})
      : super(const ParentDiaryInitial()) {
    on<LoadParentDiaryMenu>((event, emit) async {
      emit(const ParentDiaryLoading());
      try {
        final items = await getParentDiaryMenu();
        emit(ParentDiaryLoaded(items));
      } catch (e) {
        emit(ParentDiaryError(e.toString()));
      }
    });
  }
}
