import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InstituteCalendarDay {
  final int dayBS;
  final int dayAD;
  final bool isToday;
  final bool isHoliday;
  final bool isCurrentMonth;
  final String? tithi;
  final bool hasEvent;

  InstituteCalendarDay({
    required this.dayBS,
    required this.dayAD,
    this.isToday = false,
    this.isHoliday = false,
    this.isCurrentMonth = true,
    this.tithi,
    this.hasEvent = false,
  });
}

class UpcomingEvent {
  final String id;
  final String title;
  final String dateBS;
  final int daysLeft;

  UpcomingEvent({
    required this.id,
    required this.title,
    required this.dateBS,
    required this.daysLeft,
  });
}

final sampleDays = List.generate(
  35,
  (index) => InstituteCalendarDay(
    dayBS: index + 1,
    dayAD: index + 1,
    isToday: index == 2,
    isHoliday: index % 6 == 0,
    hasEvent: index % 5 == 0,
  ),
);

final sampleEvents = [
  UpcomingEvent(
    id: "1",
    title: "Guru Govind Singh Jayanti",
    dateBS: "Poush 21, 2082",
    daysLeft: 2,
  ),
  UpcomingEvent(
    id: "2",
    title: "Mid Term Exam",
    dateBS: "Poush 25, 2082",
    daysLeft: 6,
  ),
];

class StudentCalendarPage extends StatefulWidget {
  const StudentCalendarPage({super.key});

  @override
  State<StudentCalendarPage> createState() => _StudentCalendarPageState();
}

class _StudentCalendarPageState extends State<StudentCalendarPage>
    with SingleTickerProviderStateMixin {
  late DateTime selectedMonth;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    selectedMonth = DateTime.now();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void navigateMonth(int delta) {
    setState(() {
      selectedMonth = DateTime(selectedMonth.year, selectedMonth.month + delta);
    });
  }

  @override
  Widget build(BuildContext context) {
    final daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    double dayWidth = (MediaQuery.of(context).size.width - 32 - 24) / 7;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text("Institute Calendar"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFB71C1C), Color(0xFFD32F2F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Page Header
            FadeTransition(
              opacity: _animationController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.home, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text("Home", style: TextStyle(color: Colors.grey)),
                      Icon(Icons.chevron_right, size: 16, color: Colors.grey),
                      Text(
                        "Institute Calendar",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Institute Calendar",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "School events, holidays, and academic schedule",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),

            // Calendar Controls
            FadeTransition(
              opacity: _animationController,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.MMMM().format(selectedMonth) +
                            " " +
                            selectedMonth.year.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFB71C1C),
                        ),
                      ),
                      Text(
                        "Dec-Jan 2025/2026 A.D.",
                        style: TextStyle(color: Colors.grey[400], fontSize: 12),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => navigateMonth(-1),
                        icon: const Icon(Icons.chevron_left),
                      ),
                      TextButton(
                        onPressed: () =>
                            setState(() => selectedMonth = DateTime.now()),
                        child: const Text(
                          "Today",
                          style: TextStyle(color: Color(0xFFB71C1C)),
                        ),
                      ),
                      IconButton(
                        onPressed: () => navigateMonth(1),
                        icon: const Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Calendar Grid
            FadeTransition(
              opacity: _animationController,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Weekdays
                    Row(
                      children: daysOfWeek
                          .map(
                            (d) => Expanded(
                              child: Center(
                                child: Text(
                                  d,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 6),
                    // Days
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: sampleDays.map((day) {
                        Color bgColor;
                        Color textColor;
                        if (day.isToday) {
                          bgColor = const Color(0xFFB71C1C);
                          textColor = Colors.white;
                        } else if (day.isHoliday) {
                          bgColor = Colors.red[50]!;
                          textColor = Colors.red;
                        } else if (!day.isCurrentMonth) {
                          bgColor = Colors.grey.shade100;
                          textColor = Colors.grey;
                        } else {
                          bgColor = Colors.white;
                          textColor = Colors.black87;
                        }

                        return GestureDetector(
                          onTap: () {},
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: dayWidth,
                            height: dayWidth,
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(12),
                              border: day.hasEvent
                                  ? Border.all(color: Colors.blue, width: 1.2)
                                  : null,
                              boxShadow: day.isToday
                                  ? [
                                      BoxShadow(
                                        color: Colors.red.withOpacity(0.2),
                                        blurRadius: 6,
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${day.dayBS}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: textColor,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        "${day.dayAD}",
                                        style: TextStyle(
                                          fontSize: 9,
                                          color: textColor.withOpacity(0.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (day.tithi != null)
                                  Positioned(
                                    bottom: 2,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: Text(
                                        day.tithi!,
                                        style: const TextStyle(
                                          fontSize: 8,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                if (day.hasEvent)
                                  Positioned(
                                    top: 6,
                                    right: 6,
                                    child: Container(
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Today Card
            FadeTransition(
              opacity: _animationController,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFB71C1C), Color(0xFFD32F2F)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Today's Highlight",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Poush 21, 2082",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.notifications,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Guru Govind Singh Jayanti - Cultural Celebration",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "The institute will observe a short celebration during the first period.",
                      style: TextStyle(fontSize: 10, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Upcoming Events
            FadeTransition(
              opacity: _animationController,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.notifications, color: Color(0xFFB71C1C)),
                        SizedBox(width: 8),
                        Text(
                          "Upcoming Events",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: sampleEvents
                          .map(
                            (e) => ListTile(
                              leading: const Icon(
                                Icons.event,
                                color: Color(0xFFB71C1C),
                              ),
                              title: Text(
                                e.title,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                "${e.dateBS} • ${e.daysLeft}d left",
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "View All Events",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.chevron_right,
                            size: 12,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
