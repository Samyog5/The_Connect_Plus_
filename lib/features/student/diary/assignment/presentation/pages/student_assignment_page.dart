import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: _buildStatsCard(),
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
                _buildAssignmentList(),
                const Center(child: Text("No completed assignments yet")),
              ],
            ),
          ),
        ],
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

  Widget _buildStatsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4338CA), Color(0xFF6366F1)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Keep it up!",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                SizedBox(height: 4),
                Text(
                  "80% Done",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 60,
            width: 60,
            child: CircularProgressIndicator(
              value: 0.8,
              strokeWidth: 8,
              backgroundColor: Colors.white24,
              color: Colors.white,
              strokeCap: StrokeCap.round,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignmentList() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 2,
      itemBuilder: (context, index) => const ModernAssignmentCard(),
    );
  }
}

class ModernAssignmentCard extends StatelessWidget {
  const ModernAssignmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE2E8F0).withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _subjectTag(
                      "Mathematics",
                      const Color(0xFFE0E7FF),
                      const Color(0xFF4338CA),
                    ),
                    const Text(
                      "2 Days Left",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  "Advanced Algebra Worksheet",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Focus on quadratic equations and function mapping. Submit the PDF version.",
                  style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_filled_rounded,
                      size: 16,
                      color: Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      "Due Jan 20, 2026",
                      style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
                    ),
                    const Spacer(),
                    _buildAvatars(),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
              ),
            ),
            child: const Text(
              "Open Assignment",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF4338CA),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _subjectTag(String text, Color bg, Color textCol) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textCol,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildAvatars() {
    return SizedBox(
      width: 60,
      height: 25,
      child: Stack(
        children: List.generate(
          3,
          (index) => Positioned(
            left: index * 15,
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.blueGrey[100 * (index + 1)],
              ),
            ),
          ),
        ),
      ),
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
