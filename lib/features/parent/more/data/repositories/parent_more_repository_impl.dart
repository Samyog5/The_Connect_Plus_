import 'package:tcp/features/parent/more/data/datasources/parent_more_menu_data_source.dart';
import 'package:tcp/features/parent/more/domain/entities/parent_more_menu_item.dart';
import 'package:tcp/features/parent/more/domain/repositories/parent_more_repository.dart';

class ParentMoreRepositoryImpl implements ParentMoreRepository {
  final ParentMoreMenuDataSource menuDataSource;

  ParentMoreRepositoryImpl({required this.menuDataSource});

  @override
  Future<List<ParentMoreMenuItem>> getMenuItems() {
    return menuDataSource.getMenuItems();
  }
}
