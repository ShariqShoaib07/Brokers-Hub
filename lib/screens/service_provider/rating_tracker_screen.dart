import 'package:flutter/material.dart';
import 'package:brokers_hub/core/constants/app_colors.dart';
import 'package:brokers_hub/core/constants/app_text_styles.dart';

class RatingTrackerScreen extends StatelessWidget {
  final List<Map<String, dynamic>> reviews = [
    {"rating": 4.5, "feedback": "Great job, completed before deadline", "date": "20 June"},
    {"rating": 5.0, "feedback": "Excellent communication and quality", "date": "15 June"},
    {"rating": 3.5, "feedback": "Good work but slightly delayed", "date": "10 June"},
    {"rating": 4.0, "feedback": "Professional service", "date": "5 June"},
  ];

  RatingTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final averageRating = _calculateAverageRating();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Ratings',
          style: AppTextStyles.headlineSmall(context),
        ),
      ),
      body: Column(
        children: [
          // Average Rating Section
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Average Rating',
                  style: AppTextStyles.bodyLarge(context)?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: AppColors.warningYellow,
                      size: 48,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      averageRating.toStringAsFixed(1),
                      style: AppTextStyles.headlineLarge(context)?.copyWith(
                        color: theme.colorScheme.onBackground,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '/5',
                      style: AppTextStyles.bodyLarge(context)?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Reviews List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Rating Stars
                        Row(
                          children: [
                            _buildStarRating(review['rating']),
                            const SizedBox(width: 8),
                            Text(
                              review['date'],
                              style: AppTextStyles.bodySmall(context)?.copyWith(
                                color: theme.colorScheme.onSurface.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Feedback
                        Text(
                          review['feedback'],
                          style: AppTextStyles.bodyMedium(context),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStarRating(double rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor()
              ? Icons.star_rounded
              : (index < rating ? Icons.star_half_rounded : Icons.star_outline_rounded),
          color: AppColors.warningYellow,
          size: 20,
        );
      }),
    );
  }

  double _calculateAverageRating() {
    if (reviews.isEmpty) return 0;
    return reviews.map((r) => r['rating']).reduce((a, b) => a + b) / reviews.length;
  }
}