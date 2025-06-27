import 'package:flutter/material.dart';
import 'package:brokers_hub/core/constants/app_colors.dart';
import 'package:brokers_hub/core/constants/app_text_styles.dart';
import 'package:brokers_hub/widgets/common/custom_button.dart';
import 'package:brokers_hub/widgets/common/custom_card.dart';

class PayoutRequestsScreen extends StatefulWidget {
  const PayoutRequestsScreen({super.key});

  @override
  State<PayoutRequestsScreen> createState() => _PayoutRequestsScreenState();
}

class _PayoutRequestsScreenState extends State<PayoutRequestsScreen> {
  final List<Map<String, dynamic>> _payouts = [
    {"user": "Ali", "amount": 15000, "method": "JazzCash", "status": "pending"},
    {"user": "Sara", "amount": 10000, "method": "Bank", "status": "approved"},
    {"user": "John", "amount": 25000, "method": "EasyPaisa", "status": "pending"},
    {"user": "Emma", "amount": 18000, "method": "Bank", "status": "rejected"},
  ];

  void _approvePayout(int index) {
    setState(() {
      _payouts[index]['status'] = 'approved';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payout to ${_payouts[index]['user']} approved'),
        backgroundColor: AppColors.successGreen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payout Requests',
          style: AppTextStyles.headlineSmall(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _payouts.length,
        itemBuilder: (context, index) {
          final payout = _payouts[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: CustomCard(
              title: '${payout['user']} • ${payout['method']}',
              subtitle: 'Amount: ${payout['amount']} PKR',
              badgeText: payout['status'],
              onTap: () {},
              trailing: payout['status'] == 'pending'
                  ? CustomButton(
                onPressed: () => _approvePayout(index),
                label: 'Approve',
                backgroundColor: AppColors.successGreen,
                isFullWidth: false,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              )
                  : null,
            ),
          );
        },
      ),
    );
  }
}