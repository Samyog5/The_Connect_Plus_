import 'package:equatable/equatable.dart';
import 'package:tcp/features/parent/more/domain/entities/parent_more_menu_item.dart';

abstract class ParentMoreState extends Equatable {
  const ParentMoreState();

  @override
  List<Object?> get props => [];
}

class ParentMoreInitial extends ParentMoreState {
  const ParentMoreInitial();
}

class ParentMoreLoading extends ParentMoreState {
  const ParentMoreLoading();
}

class ParentMoreLoaded extends ParentMoreState {
  final List<ParentMoreMenuItem> items;

  const ParentMoreLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class ParentMoreError extends ParentMoreState {
  final String message;

  const ParentMoreError(this.message);

  @override
  List<Object?> get props => [message];
}
