import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:brokers_hub/core/constants/app_colors.dart';
import 'package:brokers_hub/core/constants/app_text_styles.dart';
import 'package:brokers_hub/providers/wallet_provider.dart';
import 'package:brokers_hub/widgets/common/custom_button.dart';
import 'package:brokers_hub/widgets/common/app_input_field.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);
    final transactions = walletProvider.transactions;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Wallet',
          style: AppTextStyles.headlineSmall(context),
        ),
      ),
      body: Column(
        children: [
          // Balance Card
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'Available Balance',
                      style: AppTextStyles.labelLarge(context),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Rs. ${walletProvider.balance.toStringAsFixed(2)}',
                      style: AppTextStyles.headlineMedium(context)?.copyWith(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomButton(
                      onPressed: () => _showWithdrawalModal(context),
                      label: 'Withdraw',
                      isFullWidth: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Transaction History
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Transaction History',
                style: AppTextStyles.titleLarge(context),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: transactions.isEmpty
                ? Center(
              child: Text(
                'No transactions yet',
                style: AppTextStyles.bodyMedium(context)?.copyWith(
                  color: Colors.grey,
                ),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.only(bottom: 16),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    leading: Icon(
                      transaction.type == 'commission'
                          ? Icons.attach_money
                          : Icons.money_off,
                      color: transaction.type == 'commission'
                          ? AppColors.successGreen
                          : AppColors.errorRed,
                    ),
                    title: Text(
                      transaction.description,
                      style: AppTextStyles.bodyMedium(context),
                    ),
                    subtitle: Text(
                      _formatDate(transaction.date),
                      style: AppTextStyles.bodySmall(context),
                    ),
                    trailing: Text(
                      '${transaction.type == 'commission' ? '+' : '-'}Rs. ${transaction.amount.abs().toStringAsFixed(2)}',
                      style: AppTextStyles.bodyMedium(context)?.copyWith(
                        color: transaction.type == 'commission'
                            ? AppColors.successGreen
                            : AppColors.errorRed,
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
    );
  }

  void _showWithdrawalModal(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);
    final formKey = GlobalKey<FormState>();
    final amountController = TextEditingController();
    String selectedMethod = 'JazzCash';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Withdraw Funds',
                    style: AppTextStyles.headlineSmall(context),
                  ),
                  const SizedBox(height: 24),
                  AppInputField(
                    controller: amountController,
                    label: 'Amount (PKR)',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter amount';
                      }
                      final amount = double.tryParse(value);
                      if (amount == null || amount <= 0) {
                        return 'Enter valid amount';
                      }
                      if (amount > walletProvider.balance) {
                        return 'Amount exceeds balance';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedMethod,
                    decoration: InputDecoration(
                      labelText: 'Withdrawal Method',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: ['JazzCash', 'EasyPaisa', 'Bank']
                        .map((method) => DropdownMenuItem(
                      value: method,
                      child: Text(method),
                    ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        selectedMethod = value;
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final amount = double.parse(amountController.text);
                        try {
                          await walletProvider.withdraw(amount, selectedMethod);
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                            msg: 'Withdrawal request submitted',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: AppColors.successGreen,
                            textColor: Colors.white,
                          );
                        } catch (e) {
                          Fluttertoast.showToast(
                            msg: 'Withdrawal failed: ${e.toString()}',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: AppColors.errorRed,
                            textColor: Colors.white,
                          );
                        }
                      }
                    },
                    label: 'Submit Withdrawal',
                    isFullWidth: true,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}