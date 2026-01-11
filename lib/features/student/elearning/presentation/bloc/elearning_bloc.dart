import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/elearning.dart';
import '../../domain/usecases/get_elearning_materials.dart';
import 'elearning_event.dart';
import 'elearning_state.dart';

class ELearningBloc extends Bloc<ELearningEvent, ELearningState> {
  final GetELearningMaterials getMaterials;

  List<ELearning> allMaterials = [];

  ELearningBloc(this.getMaterials) : super(ELearningLoading()) {
    on<LoadELearning>(_load);
    on<SearchELearning>(_search);
    on<FilterByCategory>(_filter);
  }

  Future<void> _load(LoadELearning event, Emitter<ELearningState> emit) async {
    emit(ELearningLoading());

    final data = await getMaterials();

    allMaterials = data;

    emit(ELearningLoaded(data, 'All'));
  }

  void _search(SearchELearning event, Emitter<ELearningState> emit) {
    final filtered = allMaterials.where((e) {
      final q = event.query.toLowerCase();
      return e.title.toLowerCase().contains(q) ||
          e.subject.toLowerCase().contains(q);
    }).toList();

    emit(ELearningLoaded(filtered, 'All'));
  }

  void _filter(FilterByCategory event, Emitter<ELearningState> emit) {
    final filtered = event.category == 'All'
        ? allMaterials
        : allMaterials.where((e) => e.category == event.category).toList();

    emit(ELearningLoaded(filtered, event.category));
  }
}
