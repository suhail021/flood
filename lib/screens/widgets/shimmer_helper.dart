import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHelper {
  static Widget buildShimmer({
    required BuildContext context,
    required double width,
    required double height,
    double borderRadius = 8,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

class RiskCardShimmer extends StatelessWidget {
  const RiskCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      itemCount: 5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[900] : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? Colors.white10 : Colors.grey.shade200,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // Icon Placeholder
              ShimmerHelper.buildShimmer(
                context: context,
                width: 50,
                height: 50,
                borderRadius: 25,
              ),
              const SizedBox(width: 16),
              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerHelper.buildShimmer(
                      context: context,
                      width: 100,
                      height: 16,
                    ),
                    const SizedBox(height: 8),
                    ShimmerHelper.buildShimmer(
                      context: context,
                      width: 60,
                      height: 12,
                    ),
                    const SizedBox(height: 8),
                    ShimmerHelper.buildShimmer(
                      context: context,
                      width: 80,
                      height: 10,
                    ),
                  ],
                ),
              ),
              // Progress Bar Placeholder
              Column(
                children: [
                  ShimmerHelper.buildShimmer(
                    context: context,
                    width: 60,
                    height: 6,
                    borderRadius: 3,
                  ),
                  const SizedBox(height: 8),
                  ShimmerHelper.buildShimmer(
                    context: context,
                    width: 30,
                    height: 12,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class ReportCardShimmer extends StatelessWidget {
  const ReportCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: isDark ? Colors.white10 : Colors.grey.shade200,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Leading Icon
                ShimmerHelper.buildShimmer(
                  context: context,
                  width: 44,
                  height: 44,
                  borderRadius: 22,
                ),
                const SizedBox(width: 16),
                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerHelper.buildShimmer(
                        context: context,
                        width: 150,
                        height: 16,
                      ), // Title
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          ShimmerHelper.buildShimmer(
                            context: context,
                            width: 14,
                            height: 14,
                            borderRadius: 2,
                          ), // Icon
                          const SizedBox(width: 4),
                          ShimmerHelper.buildShimmer(
                            context: context,
                            width: 80,
                            height: 12,
                          ), // Date
                        ],
                      ),
                      const SizedBox(height: 8),
                      ShimmerHelper.buildShimmer(
                        context: context,
                        width: 60,
                        height: 20,
                        borderRadius: 8,
                      ), // Status Badge
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class NotificationCardShimmer extends StatelessWidget {
  const NotificationCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: isDark ? Colors.white10 : Colors.grey.shade200,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    // Icon
                    ShimmerHelper.buildShimmer(
                      context: context,
                      width: 44,
                      height: 44,
                      borderRadius: 22,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerHelper.buildShimmer(
                            context: context,
                            width: 120,
                            height: 16,
                          ), // Title
                          const SizedBox(height: 4),
                          ShimmerHelper.buildShimmer(
                            context: context,
                            width: 80,
                            height: 12,
                          ), // Subtitle
                        ],
                      ),
                    ),
                    // Risk Badge
                    ShimmerHelper.buildShimmer(
                      context: context,
                      width: 40,
                      height: 24,
                      borderRadius: 12,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Footer Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ShimmerHelper.buildShimmer(
                          context: context,
                          width: 12,
                          height: 12,
                          borderRadius: 6,
                        ),
                        const SizedBox(width: 4),
                        ShimmerHelper.buildShimmer(
                          context: context,
                          width: 60,
                          height: 10,
                        ),
                      ],
                    ),
                    ShimmerHelper.buildShimmer(
                      context: context,
                      width: 60,
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
