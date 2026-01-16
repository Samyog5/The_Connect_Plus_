import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tcp/features/student/news/data/repositories/news_repository_impl.dart';
import 'package:tcp/features/student/news/domain/usecases/get_news.dart';
import 'package:tcp/features/student/news/presentation/bloc/news_bloc.dart';
import 'package:tcp/features/student/news/presentation/bloc/news_event.dart';
import 'package:tcp/features/student/news/presentation/bloc/news_state.dart';
import 'package:tcp/features/student/news/presentation/widgets/news_card.dart';
import 'package:tcp/features/student/news/presentation/widgets/news_header.dart';
import 'package:tcp/features/student/news/presentation/widgets/news_search_bar.dart';
import 'package:tcp/features/student/news/presentation/widgets/news_filter_chips.dart';
import 'package:tcp/features/student/news/presentation/widgets/news_empty_state.dart';
import 'package:tcp/features/student/news/presentation/widgets/news_newsletter_section.dart';

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
              sliver: SliverToBoxAdapter(
                child: NewsHeader(
                  title: 'Educational News Hub',
                  subtitle:
                      'Your daily source for academic updates, trends, and global insights',
                ),
              ),
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
                      return const SliverToBoxAdapter(child: NewsEmptyState());
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
              sliver: SliverToBoxAdapter(
                child: NewsNewsletterSection(
                  onSubscribe: () {},
                  onViewPastIssues: () {},
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 48)),
          ],
        ),
      ),
    );
  }

  Widget _buildControls(BuildContext context) {
    return Column(
          children: [
            // Search
            NewsSearchBar(
              controller: _searchController,
              onChanged: (value) {
                context.read<NewsBloc>().add(SearchNews(value));
              },
            ),
            const SizedBox(height: 24),

            // Filter List
            BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                String current = 'All';
                if (state is NewsLoaded) {
                  current = state.activeCategory;
                }
                return NewsFilterChips(
                  categories: _categories,
                  activeCategory: current,
                  onCategorySelected: (category) {
                    context.read<NewsBloc>().add(FilterNews(category));
                  },
                );
              },
            ),
          ],
        )
        .animate(delay: 200.ms)
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.1, end: 0);
  }
}
