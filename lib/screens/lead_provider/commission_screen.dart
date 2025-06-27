import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brokers_hub/core/constants/app_colors.dart';
import 'package:brokers_hub/core/constants/app_text_styles.dart';
import 'package:brokers_hub/providers/wallet_provider.dart';
import 'package:brokers_hub/widgets/common/empty_state.dart';

class CommissionScreen extends StatelessWidget {
  const CommissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);
    final commissions = walletProvider.transactions
        .where((t) => t.type == 'commission')
        .toList()
        .reversed
        .toList(); // Show newest first

    final totalEarnings = commissions.fold(
        0.0, (sum, transaction) => sum + transaction.amount);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Commission History',
          style: AppTextStyles.headlineSmall(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Total Earnings Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Total Earnings',
                      style: AppTextStyles.labelLarge(context),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Rs. ${totalEarnings.toStringAsFixed(2)}',
                      style: AppTextStyles.headlineMedium(context)?.copyWith(
                        color: AppColors.successGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Commission History',
              style: AppTextStyles.headlineMedium(context),
            ),
            const SizedBox(height: 16),
            // Commission List
            Expanded(
              child: commissions.isEmpty
                  ? const EmptyState(
                icon: Icons.money_off,
                title: 'No Commissions Yet',
                subtitle: 'Your earned commissions will appear here',
              )
                  : ListView.separated(
                itemCount: commissions.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final commission = commissions[index];
                  return Card(
                    elevation: 1,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      leading: CircleAvatar(
                        backgroundColor:
                        AppColors.successGreen.withOpacity(0.2),
                        child: Icon(
                          Icons.attach_money,
                          color: AppColors.successGreen,
                        ),
                      ),
                      title: Text(
                        commission.description,
                        style: AppTextStyles.titleMedium(context),
                      ),
                      subtitle: Text(
                        _formatDate(commission.date),
                        style: AppTextStyles.bodySmall(context),
                      ),
                      trailing: Text(
                        '+Rs. ${commission.amount.toStringAsFixed(2)}',
                        style: AppTextStyles.titleMedium(context)?.copyWith(
                          color: AppColors.successGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day} ${_getMonthName(date.month)} ${date.year}';
  }

  String _getMonthName(int month) {
    return [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ][month - 1];
  }
}