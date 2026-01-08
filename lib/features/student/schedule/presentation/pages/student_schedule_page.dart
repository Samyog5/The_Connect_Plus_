import 'package:flutter/material.dart';
import 'package:tcp/features/student/attendance/presentation/pages/student_attendance_page.dart';
import 'package:tcp/features/student/widgets/custom_navbar.dart';
import '../../../home/presentation/pages/student_home_page.dart';
import '../../../notices/presentation/pages/student_notices_page.dart';
import 'package:tcp/features/student/more/presentation/pages/student_more_page.dart';

class StudentSchedulePage extends StatefulWidget {
  final String userName;
  final String userAvatar;

  const StudentSchedulePage({
    super.key,
    required this.userName,
    required this.userAvatar,
  });

  @override
  State<StudentSchedulePage> createState() => _StudentSchedulePageState();
}

class _StudentSchedulePageState extends State<StudentSchedulePage> {
  int _selectedNavIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        elevation: 6,
        toolbarHeight: 70,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFB71C1C), Color(0xFFD32F2F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Weekly Schedule',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildScheduleCards(),
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedNavIndex,
        onTabChanged: _onNavChanged,
        isBottomNav: true,
      ),
    );
  }

  void _onNavChanged(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => StudentHomePage(
            userName: widget.userName,
            userRole: 'Student',
            userAvatar: widget.userAvatar,
            className: 'Class 10 - A',
          ),
        ),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => StudentAttendancePage(
            userName: widget.userName,
            userAvatar: widget.userAvatar,
          ),
        ),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => StudentNoticesPage(
            userName: widget.userName,
            userAvatar: widget.userAvatar,
          ),
        ),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => StudentMorePage(
            userName: widget.userName,
            userAvatar: widget.userAvatar,
          ),
        ),
      );
    }
  }

  List<Widget> _buildScheduleCards() {
    final schedules = [
      {
        'day': 'Monday',
        'classes': [
          {
            'time': '09:00 AM',
            'subject': 'Mathematics',
            'teacher': 'Mr. Sharma',
            'room': 'A101',
          },
          {
            'time': '10:30 AM',
            'subject': 'English',
            'teacher': 'Mrs. Karki',
            'room': 'B205',
          },
          {
            'time': '12:00 PM',
            'subject': 'Science',
            'teacher': 'Ms. Pradhan',
            'room': 'C310',
          },
        ],
      },
      {
        'day': 'Tuesday',
        'classes': [
          {
            'time': '09:00 AM',
            'subject': 'History',
            'teacher': 'Mr. Patel',
            'room': 'D401',
          },
          {
            'time': '10:30 AM',
            'subject': 'Mathematics',
            'teacher': 'Mr. Sharma',
            'room': 'A101',
          },
          {
            'time': '01:00 PM',
            'subject': 'Computer',
            'teacher': 'Mr. Tech',
            'room': 'E505',
          },
        ],
      },
    ];

    return schedules.map((schedule) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              schedule['day'] as String,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFB71C1C),
              ),
            ),
          ),
          ...((schedule['classes'] as List).map((classItem) {
            return Card(
              elevation: 3,
              shadowColor: Colors.grey.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.red.shade50, Colors.red.shade100],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        classItem['time'] as String,
                        style: const TextStyle(
                          color: Color(0xFFB71C1C),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            classItem['subject'] as String,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 14,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                classItem['teacher'] as String,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Icon(
                                Icons.meeting_room,
                                size: 14,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                classItem['room'] as String,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            );
          })).toList(),
        ],
      );
    }).toList();
  }
}
