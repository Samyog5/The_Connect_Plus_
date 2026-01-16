import 'package:flutter/material.dart';

class DiaryLoadingShimmer extends StatefulWidget {
  const DiaryLoadingShimmer({super.key});

  @override
  State<DiaryLoadingShimmer> createState() => _DiaryLoadingShimmerState();
}

class _DiaryLoadingShimmerState extends State<DiaryLoadingShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 0.85,
      children: List.generate(6, (index) => _buildShimmerCard()),
    );
  }

  Widget _buildShimmerCard() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey[200]!, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildShimmerBox(52, 52, borderRadius: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildShimmerBox(12, 40),
                  const SizedBox(height: 8),
                  _buildShimmerBox(16, 80),
                  const SizedBox(height: 8),
                  _buildShimmerBox(11, 100),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShimmerBox(
    double height,
    double width, {
    double borderRadius = 4,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
