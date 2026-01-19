import 'package:tcp/features/parent/more/data/datasources/parent_more_menu_data_source.dart';
import 'package:tcp/features/parent/more/domain/entities/parent_more_menu_destination.dart';
import 'package:tcp/features/parent/more/domain/entities/parent_more_menu_item.dart';

class ParentMoreMenuDataSourceImpl implements ParentMoreMenuDataSource {
  @override
  Future<List<ParentMoreMenuItem>> getMenuItems() async {
    // Local list for now (can be replaced with remote config later).
    await Future.delayed(const Duration(milliseconds: 150));

    return const [
      ParentMoreMenuItem(
        destination: ParentMoreMenuDestination.headOfInstitute,
        label: 'Head of Institute',
      ),
      ParentMoreMenuItem(
        destination: ParentMoreMenuDestination.noticesTab,
        label: 'Notices',
      ),
      ParentMoreMenuItem(
        destination: ParentMoreMenuDestination.attendanceTab,
        label: 'Attendance',
      ),
      ParentMoreMenuItem(
        destination: ParentMoreMenuDestination.diary,
        label: 'Diary',
      ),
      ParentMoreMenuItem(
        destination: ParentMoreMenuDestination.eventsActivities,
        label: 'Event & Activities',
      ),
      ParentMoreMenuItem(
        destination: ParentMoreMenuDestination.feeManagement,
        label: 'Fee Management',
      ),
      ParentMoreMenuItem(
        destination: ParentMoreMenuDestination.examManagement,
        label: 'Exam Management',
      ),
      ParentMoreMenuItem(
        destination: ParentMoreMenuDestination.library,
        label: 'Library',
      ),
      ParentMoreMenuItem(
        destination: ParentMoreMenuDestination.learningMaterials,
        label: 'Learning Materials',
      ),
      ParentMoreMenuItem(
        destination: ParentMoreMenuDestination.vehicleManagement,
        label: 'Vehicle Management',
      ),
      ParentMoreMenuItem(
        destination: ParentMoreMenuDestination.instituteInformation,
        label: 'Institute Information',
      ),
      ParentMoreMenuItem(
        destination: ParentMoreMenuDestination.invitationsGreetings,
        label: 'Invitation / Greetings',
      ),
      ParentMoreMenuItem(
        destination: ParentMoreMenuDestination.educationalNews,
        label: 'Educational News',
      ),
      ParentMoreMenuItem(
        destination: ParentMoreMenuDestination.zoomClass,
        label: 'Zoom Class',
      ),
      ParentMoreMenuItem(
        destination: ParentMoreMenuDestination.eLearning,
        label: 'e-Learning',
      ),
      ParentMoreMenuItem(
        destination: ParentMoreMenuDestination.others,
        label: 'Others',
      ),
    ];
  }
}
