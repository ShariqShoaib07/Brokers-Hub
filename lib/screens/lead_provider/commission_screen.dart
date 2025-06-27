// lib/screens/lead_provider/commission_screen.dart
import 'package:flutter/material.dart';
import 'package:brokers_hub/core/constants/app_colors.dart';
import 'package:brokers_hub/core/constants/app_text_styles.dart';
import 'package:brokers_hub/models/commission_model.dart';

class CommissionScreen extends StatelessWidget {
  // Mock data - in a real app, this would come from an API or database
  final List<Commission> commissions = [
    Commission(amount: 15000, leadTitle: 'Solar Setup', date: '20 June'),
    Commission(amount: 8500, leadTitle: 'Home Loan', date: '15 June'),
    Commission(amount: 12000, leadTitle: 'Business Loan', date: '10 June'),
    Commission(amount: 7500, leadTitle: 'Car Insurance', date: '5 June'),
    Commission(amount: 20000, leadTitle: 'Property Deal', date: '1 June'),
  ];

  CommissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            Text(
              'Your Earnings',
              style: AppTextStyles.headlineMedium(context),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: commissions.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final commission = commissions[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      commission.leadTitle,
                      style: AppTextStyles.titleMedium(context),
                    ),
                    subtitle: Text(
                      commission.date,
                      style: AppTextStyles.bodySmall(context),
                    ),
                    trailing: Text(
                      'Rs. ${commission.amount.toStringAsFixed(0)}',
                      style: AppTextStyles.titleMedium(context)?.copyWith(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.bold,
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
}