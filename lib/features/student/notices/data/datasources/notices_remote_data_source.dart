import '../models/notice_model.dart';

abstract class NoticesRemoteDataSource {
  Future<List<NoticeModel>> getNotices();
}

class NoticesRemoteDataSourceImpl implements NoticesRemoteDataSource {
  @override
  Future<List<NoticeModel>> getNotices() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Return mock data
    return [
      const NoticeModel(
        id: '1',
        type: 'Academic',
        title: 'Final Exam Schedule Released',
        description:
            'The final examination schedule has been released. Classes will end on March 10, 2026.',
        date: 'Jan 5, 2026',
        author: 'Academic Department',
        priority: 'High',
        isUnread: true,
      ),
      const NoticeModel(
        id: '2',
        type: 'Event',
        title: 'Sports Day Next Month',
        description:
            'Annual sports day will be held on February 15, 2026. All students are encouraged to participate.',
        date: 'Jan 3, 2026',
        author: 'Sports Committee',
        priority: 'Medium',
        isUnread: false,
      ),
      const NoticeModel(
        id: '3',
        type: 'Holiday',
        title: 'Republic Day Holiday',
        description:
            'School will remain closed on January 26, 2026 for Republic Day celebration.',
        date: 'Jan 1, 2026',
        author: 'Administration',
        priority: 'Normal',
        isUnread: false,
      ),
      const NoticeModel(
        id: '4',
        type: 'Academic',
        title: 'Winter Vacation Extended',
        description:
            'Due to weather conditions, winter vacation has been extended by 2 days.',
        date: 'Dec 28, 2025',
        author: 'Academic Department',
        priority: 'Medium',
        isUnread: false,
      ),
    ];
  }
}
