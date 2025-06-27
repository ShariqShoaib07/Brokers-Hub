import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brokers_hub/providers/auth_provider.dart';
import 'package:brokers_hub/widgets/layout/bottom_nav_bar.dart';
import 'package:brokers_hub/widgets/common/custom_button.dart';
import 'package:brokers_hub/core/constants/app_colors.dart';
import 'package:brokers_hub/core/constants/app_text_styles.dart';

class SDashboardScreen extends StatelessWidget {
  const SDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    final textTheme = Theme.of(context).textTheme;

    // Mock stats data
    final stats = {
      'Applied Leads': 5,
      'Deals Closed': 2,
      'Commissions Earned': 'Rs. 30,000',
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Service Provider Dashboard',
          style: AppTextStyles.titleLarge(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome section
            Text(
              'Welcome, ${user?.name ?? 'Service Provider'}',
              style: AppTextStyles.headlineMedium(context),
            ),
            const SizedBox(height: 8),
            Text(
              'Here\'s your current performance',
              style: AppTextStyles.bodyMedium(context)?.copyWith(
                color: AppColors.darkTextSecondary,
              ),
            ),
            const SizedBox(height: 24),

            // Stats cards
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: stats.entries.map((entry) {
                return _StatCard(
                  title: entry.key,
                  value: entry.value.toString(),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),

            // Quick actions section
            Text(
              'Quick Actions',
              style: AppTextStyles.headlineSmall(context),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                CustomButton(
                  onPressed: () => Navigator.pushNamed(context, '/available-leads'),
                  label: 'Browse Leads',
                  backgroundColor: AppColors.primaryBlue,
                  textColor: Colors.white,
                ),
                const SizedBox(height: 12),
                CustomButton(
                  onPressed: () => Navigator.pushNamed(context, '/my-deals'),
                  label: 'My Deals',
                  backgroundColor: AppColors.secondaryPurple,
                  textColor: Colors.white,
                ),
                const SizedBox(height: 12),
                CustomButton(
                  onPressed: () => Navigator.pushNamed(context, '/earnings'),
                  label: 'Earnings',
                  backgroundColor: AppColors.accentNeonPurple,
                  textColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
    );
  }
}

// Stat card widget
class _StatCard extends StatelessWidget {
  final String title;
  final String value;

  const _StatCard({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyles.labelLarge(context)?.copyWith(
                color: AppColors.darkTextSecondary,
              ),
            ),
            Text(
              value,
              style: AppTextStyles.headlineMedium(context)?.copyWith(
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}