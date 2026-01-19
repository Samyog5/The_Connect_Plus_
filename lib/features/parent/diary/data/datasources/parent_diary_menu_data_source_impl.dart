import 'package:tcp/features/parent/diary/data/datasources/parent_diary_menu_data_source.dart';
import 'package:tcp/features/parent/diary/domain/entities/parent_diary_destination.dart';
import 'package:tcp/features/parent/diary/domain/entities/parent_diary_item.dart';

class ParentDiaryMenuDataSourceImpl implements ParentDiaryMenuDataSource {
  @override
  Future<List<ParentDiaryItem>> getDiaryItems() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    return const [
      ParentDiaryItem(
        destination: ParentDiaryDestination.homework,
        label: 'Homework',
      ),
      ParentDiaryItem(
        destination: ParentDiaryDestination.calendar,
        label: 'Calendar',
      ),
      ParentDiaryItem(
        destination: ParentDiaryDestination.assignments,
        label: 'Assignments',
      ),
    ];
  }
}
