import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/assignment_bloc.dart';
import '../bloc/assignment_state.dart';
import '../widgets/assignment_stats_card.dart';
import '../widgets/assignment_item_card.dart';
import '../widgets/assignment_loading_shimmer.dart';

class StudentAssignmentPage extends StatefulWidget {
  const StudentAssignmentPage({super.key});

  @override
  State<StudentAssignmentPage> createState() => _StudentAssignmentPageState();
}

class _StudentAssignmentPageState extends State<StudentAssignmentPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),
      body: BlocBuilder<AssignmentBloc, AssignmentState>(
        builder: (context, state) {
          if (state is AssignmentLoading) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
              child: AssignmentLoadingShimmer(),
            );
          }

          if (state is AssignmentError) {
            return Center(child: Text("Error: ${state.message}"));
          }

          if (state is AssignmentLoaded) {
            return CustomScrollView(
              slivers: [
                _buildAppBar(),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: AssignmentStatsCard(
                      completionPercentage: state.completionPercentage,
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _StickyTabBarDelegate(
                    TabBar(
                      controller: _tabController,
                      labelColor: const Color(0xFF2D31FA),
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: const Color(0xFF2D31FA),
                      indicatorWeight: 3,
                      tabs: const [
                        Tab(text: "Pending"),
                        Tab(text: "Completed"),
                      ],
                    ),
                  ),
                ),
                SliverFillRemaining(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      state.pendingAssignments.isEmpty
                          ? const Center(child: Text("No pending assignments"))
                          : ListView.builder(
                              padding: const EdgeInsets.all(20),
                              itemCount: state.pendingAssignments.length,
                              itemBuilder: (context, index) =>
                                  AssignmentItemCard(
                                    assignment: state.pendingAssignments[index],
                                  ),
                            ),
                      state.completedAssignments.isEmpty
                          ? const Center(
                              child: Text("No completed assignments"),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.all(20),
                              itemCount: state.completedAssignments.length,
                              itemBuilder: (context, index) =>
                                  AssignmentItemCard(
                                    assignment:
                                        state.completedAssignments[index],
                                  ),
                            ),
                    ],
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 120.0,
      floating: false,
      pinned: true,
      backgroundColor: const Color(0xFFF3F6FF),
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        title: const Text(
          "My Tasks",
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_none_rounded,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  _StickyTabBarDelegate(this._tabBar);
  final TabBar _tabBar;
  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: const Color(0xFFF3F6FF), child: _tabBar);
  }

  @override
  bool shouldRebuild(_StickyTabBarDelegate oldDelegate) => false;
}
