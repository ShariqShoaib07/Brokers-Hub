import 'package:flutter/material.dart';
import 'package:brokers_hub/core/constants/app_colors.dart';
import 'package:brokers_hub/core/constants/app_text_styles.dart';
import 'package:brokers_hub/widgets/common/custom_card.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock report data
    final reports = [
      {
        'title': 'Monthly Transactions',
        'value': 'PKR 1,240,500',
        'change': '+12%',
        'isPositive': true,
        'icon': Icons.attach_money,
      },
      {
        'title': 'Active Users',
        'value': '1,842',
        'change': '+5.3%',
        'isPositive': true,
        'icon': Icons.people,
      },
      {
        'title': 'Pending Leads',
        'value': '127',
        'change': '-8%',
        'isPositive': false,
        'icon': Icons.pending_actions,
      },
      {
        'title': 'Completed Deals',
        'value': '94',
        'change': '+22%',
        'isPositive': true,
        'icon': Icons.check_circle,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reports Dashboard',
          style: AppTextStyles.headlineSmall(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () => _showFilterDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => _exportReports(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Performance Overview',
              style: AppTextStyles.headlineMedium(context),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              itemCount: reports.length,
              itemBuilder: (context, index) {
                final report = reports[index];
                return CustomCard(
                  title: report['title'] as String,
                  subtitle: report['value'] as String,
                  badgeText: report['change'] as String,
                  onTap: () => _showReportDetails(context, report),
                  child: Icon(
                    report['icon'] as IconData,
                    size: 32,
                    color: (report['isPositive'] as bool)
                        ? AppColors.successGreen
                        : AppColors.errorRed,
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            Text(
              'Recent Activities',
              style: AppTextStyles.headlineMedium(context),
            ),
            const SizedBox(height: 16),
            _buildActivityList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityList(BuildContext context) {
    final activities = [
      {'user': 'Ali Khan', 'action': 'completed a deal', 'time': '2 hours ago'},
      {'user': 'Sara Ahmed', 'action': 'posted new lead', 'time': '5 hours ago'},
      {'user': 'Tech Solutions', 'action': 'made payment', 'time': '1 day ago'},
      {'user': 'John Doe', 'action': 'updated profile', 'time': '2 days ago'},
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: activities.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final activity = activities[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColors.primaryBlue.withOpacity(0.2),
            child: Icon(
              Icons.person,
              color: AppColors.primaryBlue,
            ),
          ),
          title: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: activity['user'],
                  style: AppTextStyles.bodyMedium(context)?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ' ${activity['action']}',
                  style: AppTextStyles.bodyMedium(context),
                ),
              ],
            ),
          ),
          subtitle: Text(
            activity['time'] as String,
            style: AppTextStyles.bodySmall(context)?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        );
      },
    );
  }

  void _showReportDetails(BuildContext context, Map<String, dynamic> report) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(report['title'] as String),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Value: ${report['value']}',
              style: AppTextStyles.bodyLarge(context),
            ),
            const SizedBox(height: 8),
            Text(
              'Change: ${report['change']}',
              style: AppTextStyles.bodyMedium(context)?.copyWith(
                color: (report['isPositive'] as bool)
                    ? AppColors.successGreen
                    : AppColors.errorRed,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Reports'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFilterOption(context, 'Last 7 days', true),
            _buildFilterOption(context, 'Last 30 days', false),
            _buildFilterOption(context, 'This Quarter', false),
            _buildFilterOption(context, 'Custom Range', false),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOption(BuildContext context, String title, bool isSelected) {
    return ListTile(
      title: Text(title),
      trailing: isSelected
          ? Icon(Icons.check, color: AppColors.primaryBlue)
          : null,
      onTap: () {},
    );
  }

  void _exportReports(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Exporting reports...'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}