import 'package:flutter/material.dart';
import 'package:brokers_hub/core/constants/app_colors.dart';
import 'package:brokers_hub/core/constants/app_text_styles.dart';
import 'package:brokers_hub/widgets/common/custom_button.dart';
import 'package:brokers_hub/routes/app_routes.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Dashboard',
          style: AppTextStyles.headlineSmall(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overview',
              style: AppTextStyles.headlineMedium(context),
            ),
            const SizedBox(height: 16),
            _buildMetricsSection(context),
            const SizedBox(height: 24),
            Text(
              'Quick Actions',
              style: AppTextStyles.headlineMedium(context),
            ),
            const SizedBox(height: 16),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsSection(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1,
      children: [
        _buildMetricCard(
          context,
          title: 'Top Users',
          value: '42',
          color: AppColors.primaryBlue,
        ),
        _buildMetricCard(
          context,
          title: 'Top Services',
          value: '5',
          color: AppColors.secondaryPurple,
        ),
        _buildMetricCard(
          context,
          title: 'Pending Leads',
          value: '18',
          color: AppColors.warningYellow,
        ),
      ],
    );
  }

  Widget _buildMetricCard(
      BuildContext context, {
        required String title,
        required String value,
        required Color color,
      }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIconForTitle(title),
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: AppTextStyles.headlineSmall(context)?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: AppTextStyles.labelMedium(context)?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForTitle(String title) {
    switch (title) {
      case 'Top Users':
        return Icons.people_alt_outlined;
      case 'Top Services':
        return Icons.category_outlined;
      case 'Pending Leads':
        return Icons.pending_actions_outlined;
      default:
        return Icons.help_outline;
    }
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.manageUsers),
          label: 'Manage Users',
          backgroundColor: AppColors.primaryBlue,
          isFullWidth: true,
        ),
        const SizedBox(height: 12),
        CustomButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.leadApproval),
          label: 'Lead Approval Queue',
          backgroundColor: AppColors.secondaryPurple,
          isFullWidth: true,
        ),
        const SizedBox(height: 12),
        CustomButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.payoutRequests),
          label: 'Payout Requests',
          backgroundColor: AppColors.successGreen,
          isFullWidth: true,
        ),
        const SizedBox(height: 12),
        CustomButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.reports),
          label: 'View Reports',
          backgroundColor: AppColors.warningYellow,
          textColor: Colors.black,
          isFullWidth: true,
        ),
      ],
    );
  }
}