import 'package:tcp/features/parent/more/domain/entities/parent_more_menu_item.dart';

abstract class ParentMoreMenuDataSource {
  Future<List<ParentMoreMenuItem>> getMenuItems();
}
