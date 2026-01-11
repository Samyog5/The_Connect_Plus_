import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcp/features/student/library/data/repositories/library_repository_impl.dart';
import 'package:tcp/features/student/library/domain/entities/book.dart';
import 'package:tcp/features/student/library/domain/usecases/get_books.dart';
import 'package:tcp/features/student/library/presentation/bloc/library_bloc.dart';
import 'package:tcp/features/student/library/presentation/bloc/library_event.dart';
import 'package:tcp/features/student/library/presentation/bloc/library_state.dart';
import 'package:tcp/features/student/library/presentation/widgets/book_list_item.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LibraryBloc(GetBooks(LibraryRepositoryImpl()))..add(LoadBooks()),
      child: const LibraryView(),
    );
  }
}

class LibraryView extends StatefulWidget {
  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Book> _filterBooks(List<Book> books, String statusFilter) {
    if (statusFilter == 'All') return books;
    return books.where((b) => b.status == statusFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                color: const Color(0xFFF8FAFC),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    const Text(
                          'Library Books',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1E293B),
                            letterSpacing: -0.5,
                            height: 1.2,
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 400.ms)
                        .slideX(begin: -0.1, curve: Curves.easeOut),

                    const SizedBox(height: 24),

                    // Search Bar
                    Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFF1E293B,
                                ).withValues(alpha: 0.04),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            border: Border.all(
                              color: Colors.grey.withValues(alpha: 0.1),
                            ),
                          ),
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              context.read<LibraryBloc>().add(
                                SearchBooks(value),
                              );
                            },
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1E293B),
                            ),
                            decoration: InputDecoration(
                              hintText: 'Search books, authors, IDs...',
                              hintStyle: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                color: Colors.grey.shade400,
                                size: 22,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 100.ms, duration: 400.ms)
                        .slideY(begin: 0.1, curve: Curves.easeOut),
                  ],
                ),
              ),

              // Tabs
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey.shade500,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  indicatorPadding: const EdgeInsets.all(4),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  tabs: const [
                    Tab(text: 'Catalog'),
                    Tab(text: 'Issued'),
                    Tab(text: 'Returned'),
                  ],
                ),
              ).animate().fadeIn(delay: 200.ms),

              const SizedBox(height: 16),

              Expanded(
                child: BlocBuilder<LibraryBloc, LibraryState>(
                  builder: (context, state) {
                    if (state is LibraryLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is LibraryLoaded) {
                      final allBooks = state.books;
                      final issuedBooks = _filterBooks(allBooks, 'Issued');
                      final returnedBooks = _filterBooks(allBooks, 'Returned');

                      return TabBarView(
                        children: [
                          _buildBookList(allBooks),
                          _buildBookList(
                            issuedBooks,
                            emptyMessage: 'No books issued',
                          ),
                          _buildBookList(
                            returnedBooks,
                            emptyMessage: 'No returned books',
                          ),
                        ],
                      );
                    } else if (state is LibraryError) {
                      return Center(child: Text('Error: ${state.message}'));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookList(
    List<Book> books, {
    String emptyMessage = 'No books found',
  }) {
    if (books.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 64,
              color: Colors.grey.shade200,
            ),
            const SizedBox(height: 16),
            Text(
              emptyMessage,
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ).animate().fadeIn();
    }
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
      physics: const BouncingScrollPhysics(),
      itemCount: books.length,
      itemBuilder: (context, index) {
        return BookListItem(book: books[index])
            .animate(delay: (30 * index).ms)
            .fadeIn(duration: 400.ms)
            .slideY(begin: 0.1, end: 0, curve: Curves.easeOut);
      },
    );
  }
}
