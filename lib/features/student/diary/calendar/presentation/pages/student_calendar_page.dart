import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/calendar_bloc.dart';
import '../bloc/calendar_event.dart';
import '../bloc/calendar_state.dart';
import '../widgets/calendar_grid.dart';
import '../widgets/calendar_event_card.dart';
import '../widgets/calendar_loading_shimmer.dart';

class StudentCalendarPage extends StatefulWidget {
  const StudentCalendarPage({super.key});

  @override
  State<StudentCalendarPage> createState() => _StudentCalendarPageState();
}

class _StudentCalendarPageState extends State<StudentCalendarPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
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
      body: BlocBuilder<CalendarBloc, CalendarState>(
        builder: (context, state) {
          if (state is CalendarLoading) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: CalendarLoadingShimmer(),
            );
          }

          if (state is CalendarError) {
            return Center(child: Text("Error: ${state.message}"));
          }

          if (state is CalendarLoaded) {
            return SingleChildScrollView(
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
                            Icon(
                              Icons.chevron_right,
                              size: 16,
                              color: Colors.grey,
                            ),
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
                              DateFormat.MMMM().format(state.selectedMonth) +
                                  " " +
                                  state.selectedMonth.year.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFB71C1C),
                              ),
                            ),
                            Text(
                              "Dec-Jan 2025/2026 A.D.",
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => context.read<CalendarBloc>().add(
                                const NavigateMonth(delta: -1),
                              ),
                              icon: const Icon(Icons.chevron_left),
                            ),
                            TextButton(
                              onPressed: () => context.read<CalendarBloc>().add(
                                ResetToToday(),
                              ),
                              child: const Text(
                                "Today",
                                style: TextStyle(color: Color(0xFFB71C1C)),
                              ),
                            ),
                            IconButton(
                              onPressed: () => context.read<CalendarBloc>().add(
                                const NavigateMonth(delta: 1),
                              ),
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
                    child: CalendarGrid(days: state.days),
                  ),

                  const SizedBox(height: 16),

                  // Today Highlight
                  if (state.todaysHighlight != null)
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
                            Text(
                              state.todaysHighlight!.dateBS,
                              style: const TextStyle(
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
                                children: [
                                  const Icon(
                                    Icons.notifications,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      state.todaysHighlight!.description ??
                                          state.todaysHighlight!.title,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                              Icon(
                                Icons.notifications,
                                color: Color(0xFFB71C1C),
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Upcoming Events",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ...state.upcomingEvents
                              .map((e) => CalendarEventCard(event: e))
                              .toList(),
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
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
