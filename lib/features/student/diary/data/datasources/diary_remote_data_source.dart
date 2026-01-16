import '../models/diary_item_model.dart';

abstract class DiaryRemoteDataSource {
  Future<List<DiaryItemModel>> getDiaryItems();
}

class DiaryRemoteDataSourceImpl implements DiaryRemoteDataSource {
  @override
  Future<List<DiaryItemModel>> getDiaryItems() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock data - Replace with actual API call
    final mockData = [
      {
        'id': '1',
        'type': 'academic',
        'title': 'Homework',
        'description': 'Daily homework tasks',
        'count': '3 Tasks',
        'icon': 'menu_book_rounded',
        'color': 'blue',
        'route': '/homework',
      },
      {
        'id': '2',
        'type': 'academic',
        'title': 'Assignments',
        'description': 'Project submissions',
        'count': '2 Pending',
        'icon': 'assignment_rounded',
        'color': 'orange',
        'route': '/assignments',
      },
      {
        'id': '3',
        'type': 'schedule',
        'title': 'Routine',
        'description': 'Class schedule',
        'count': 'Today',
        'icon': 'schedule_rounded',
        'color': 'green',
        'route': '/schedule',
      },
      {
        'id': '4',
        'type': 'administrative',
        'title': 'Diary Sign',
        'description': 'Parent signature',
        'count': 'Required',
        'icon': 'draw_rounded',
        'color': 'purple',
        'route': '/diary-sign',
      },
      {
        'id': '5',
        'type': 'events',
        'title': 'Institute Calendar',
        'description': 'View upcoming institute events',
        'count': 'Events',
        'icon': 'calendar_month_rounded',
        'color': 'red',
        'route': '/calendar',
      },
    ];

    return mockData.map((json) => DiaryItemModel.fromJson(json)).toList();
  }
}
