import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tcp/features/student/news/data/repositories/news_repository_impl.dart';
import 'package:tcp/features/student/news/domain/usecases/get_news.dart';
import 'package:tcp/features/student/news/presentation/bloc/news_bloc.dart';
import 'package:tcp/features/student/news/presentation/bloc/news_event.dart';
import 'package:tcp/features/student/news/presentation/bloc/news_state.dart';
import 'package:tcp/features/student/news/presentation/widgets/news_card.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NewsBloc(GetNews(NewsRepositoryImpl()))..add(LoadNews()),
      child: const NewsView(),
    );
  }
}

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  final _searchController = TextEditingController();

  final List<String> _categories = [
    'All',
    'Academic',
    'Technology',
    'International',
    'Local',
    'Sports',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Slate 50
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // 1. Spacing
            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // 2. Header
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverToBoxAdapter(child: _buildHeader()),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 32)),

            // 3. Controls (Search + Filters)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverToBoxAdapter(child: _buildControls(context)),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 32)),

            // 4. News Grid
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: BlocBuilder<NewsBloc, NewsState>(
                builder: (context, state) {
                  if (state is NewsLoading) {
                    return const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFEF4444), // Red 500
                        ),
                      ),
                    );
                  } else if (state is NewsLoaded) {
                    if (state.news.isEmpty) {
                      return SliverToBoxAdapter(child: _buildEmptyState());
                    }

                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => NewsCard(
                          news: state.news[index],
                          index: index,
                          onTap: () {
                            // Navigation to details would go here
                          },
                        ),
                        childCount: state.news.length,
                      ),
                    );
                  } else if (state is NewsError) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    );
                  }
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                },
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 40)),

            // 5. Newsletter Section
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverToBoxAdapter(child: _buildNewsletterSection()),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 48)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text(
          'Educational News Hub',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1E293B),
            letterSpacing: -1,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Your daily source for academic updates, trends, and global insights',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.05, end: 0);
  }

  Widget _buildControls(BuildContext context) {
    return Column(
          children: [
            // Search
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF64748B).withValues(alpha: 0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  context.read<NewsBloc>().add(SearchNews(value));
                },
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B),
                ),
                decoration: InputDecoration(
                  hintText: 'Search academic news...',
                  hintStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: Colors.grey.shade400,
                    size: 24,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Filter List
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              child: BlocBuilder<NewsBloc, NewsState>(
                builder: (context, state) {
                  String current = 'All';
                  if (state is NewsLoaded) {
                    current = state.activeCategory;
                  }
                  return Row(
                    children: _categories.map((cat) {
                      final isActive = current == cat;
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: InkWell(
                          onTap: () {
                            context.read<NewsBloc>().add(FilterNews(cat));
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.fastOutSlowIn,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? const Color(0xFFEF4444) // Red 500
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: isActive
                                  ? [
                                      BoxShadow(
                                        color: const Color(
                                          0xFFEF4444,
                                        ).withValues(alpha: 0.3),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      ),
                                    ]
                                  : [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.05,
                                        ),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                            ),
                            child: Text(
                              cat,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                                color: isActive
                                    ? Colors.white
                                    : const Color(0xFF64748B),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        )
        .animate(delay: 200.ms)
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.1, end: 0);
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Icon(
              Icons.search_off_rounded,
              color: Colors.grey.shade300,
              size: 48,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'NO NEWS FOUND',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: Colors.grey.shade400,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your filters or search terms',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildNewsletterSection() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFEF4444).withValues(alpha: 0.08),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            const Color(0xFFEF4444).withValues(alpha: 0.03),
          ],
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF2F2), // Red 50
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.mark_email_unread_rounded,
              color: Color(0xFFEF4444),
              size: 32,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Stay Ahead of the Curve',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1E293B),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Weekly digests of the most important developments in global and local education, curated just for you.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF64748B),
              height: 1.6,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444),
                elevation: 0,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'SUBSCRIBE TO DIGEST',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {},
            child: const Text(
              'VIEW PAST ISSUES',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: Color(0xFF94A3B8),
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    ).animate(delay: 400.ms).fadeIn(duration: 800.ms).slideY(begin: 0.1, end: 0);
  }
}
