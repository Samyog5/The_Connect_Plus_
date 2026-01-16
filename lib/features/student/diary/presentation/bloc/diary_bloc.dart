import 'package:bloc/bloc.dart';
import '../../domain/usecases/get_diary_items.dart';
import 'diary_event.dart';
import 'diary_state.dart';

class DiaryBloc extends Bloc<DiaryEvent, DiaryState> {
  final GetDiaryItems getDiaryItems;

  DiaryBloc({required this.getDiaryItems}) : super(DiaryInitial()) {
    on<LoadDiary>(_onLoadDiary);
    on<FilterDiaryByType>(_onFilterDiaryByType);
  }

  Future<void> _onLoadDiary(LoadDiary event, Emitter<DiaryState> emit) async {
    emit(DiaryLoading());
    try {
      final items = await getDiaryItems();
      emit(DiaryLoaded(items: items));
    } catch (e) {
      emit(DiaryError(e.toString()));
    }
  }

  void _onFilterDiaryByType(FilterDiaryByType event, Emitter<DiaryState> emit) {
    if (state is DiaryLoaded) {
      final currentState = state as DiaryLoaded;
      emit(currentState.copyWith(selectedType: event.type));
    }
  }
}
