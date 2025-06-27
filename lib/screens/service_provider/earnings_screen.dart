import 'package:flutter/material.dart';
import 'package:brokers_hub/core/constants/app_colors.dart';
import 'package:brokers_hub/core/constants/app_text_styles.dart';
import 'package:intl/intl.dart';

class Commission {
  final double amount;
  final String leadTitle;
  final DateTime date;
  final String? serviceType;

  Commission({
    required this.amount,
    required this.leadTitle,
    required this.date,
    this.serviceType,
  });
}

class EarningsScreen extends StatelessWidget {
  // Enhanced mock data with service types
  final List<Commission> _commissions = [
    Commission(
      amount: 15000,
      leadTitle: 'Mobile App Development',
      date: DateTime(2023, 6, 12),
      serviceType: 'Tech',
    ),
    Commission(
      amount: 20000,
      leadTitle: 'Villa Construction',
      date: DateTime(2023, 6, 8),
      serviceType: 'Construction',
    ),
    Commission(
      amount: 10000,
      leadTitle: 'SEO Optimization',
      date: DateTime(2023, 6, 3),
      serviceType: 'Digital',
    ),
  ];

  EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final totalEarnings = _commissions.fold<double>(
        0, (sum, commission) => sum + commission.amount);
    final currencyFormat = NumberFormat.currency(
      symbol: 'Rs.',
      decimalDigits: 0,
      locale: 'en_IN',
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            title: Text('Earnings', style: AppTextStyles.headlineSmall(context)),
            pinned: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.filter_alt_outlined),
                onPressed: () => _showFilterDialog(context),
              ),
            ],
          ),

          // Summary Card
          SliverToBoxAdapter(
            child: _buildSummaryCard(context, currencyFormat, totalEarnings),
          ),

          // Commission List
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildCommissionCard(
                context,
                _commissions[index],
                currencyFormat,
              ),
              childCount: _commissions.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
      BuildContext context, NumberFormat format, double total) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 0,
      color: AppColors.secondaryPurple.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text('Total Earnings', style: AppTextStyles.bodyMedium(context)),
            const SizedBox(height: 8),
            Text(
              format.format(total),
              style: AppTextStyles.headlineLarge(context)?.copyWith(
                color: AppColors.secondaryPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Divider(color: AppColors.secondaryPurple.withOpacity(0.3)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Completed', _commissions.length.toString()),
                _buildStatItem('Highest', format.format(
                  _commissions.map((e) => e.amount).reduce((a, b) => a > b ? a : b),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommissionCard(
      BuildContext context, Commission commission, NumberFormat format) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: AppColors.secondaryPurple.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: _getServiceColor(commission.serviceType),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              commission.serviceType?.substring(0, 1) ?? '?',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        title: Text(
          commission.leadTitle,
          style: AppTextStyles.titleMedium(context)?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          DateFormat('dd MMM yyyy').format(commission.date),
          style: AppTextStyles.bodySmall(context),
        ),
        trailing: Text(
          format.format(commission.amount),
          style: AppTextStyles.titleMedium(context)?.copyWith(
            color: AppColors.secondaryPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.grey.shade600)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Color _getServiceColor(String? type) {
    switch (type?.toLowerCase()) {
      case 'tech':
        return Colors.blue.shade400;
      case 'construction':
        return Colors.orange.shade400;
      case 'digital':
        return Colors.purple.shade400;
      default:
        return Colors.grey.shade400;
    }
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Filter Commissions'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Would implement actual filters here
            Text('Filter options would appear here'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}