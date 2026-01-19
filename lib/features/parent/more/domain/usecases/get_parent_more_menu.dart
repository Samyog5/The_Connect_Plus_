import 'package:tcp/features/parent/more/domain/entities/parent_more_menu_item.dart';
import 'package:tcp/features/parent/more/domain/repositories/parent_more_repository.dart';

class GetParentMoreMenu {
  final ParentMoreRepository repository;

  GetParentMoreMenu(this.repository);

  Future<List<ParentMoreMenuItem>> call() {
    return repository.getMenuItems();
  }
}
