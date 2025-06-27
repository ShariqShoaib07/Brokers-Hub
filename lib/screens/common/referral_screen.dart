import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:brokers_hub/core/constants/app_colors.dart';
import 'package:brokers_hub/core/constants/app_text_styles.dart';
import 'package:brokers_hub/widgets/common/custom_button.dart';

class ReferralScreen extends StatelessWidget {
  final String referralCode;
  final List<Map<String, String>> referredUsers;

  const ReferralScreen({
    super.key,
    this.referralCode = "NEXS123ALI",
    this.referredUsers = const [
      {"name": "Bilal", "joinedOn": "10 June"},
      {"name": "Hassan", "joinedOn": "15 June"}
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Refer & Earn',
          style: AppTextStyles.headlineSmall(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Referral Header Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Invite and Earn!',
                      style: AppTextStyles.headlineMedium(context),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Share your referral code and earn commissions when your friends sign up and complete transactions',
                      style: AppTextStyles.bodyMedium(context),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    // Referral Code Box
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.primaryBlue,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            referralCode,
                            style: AppTextStyles.titleLarge(context)?.copyWith(
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.copy),
                            color: AppColors.primaryBlue,
                            onPressed: () => _copyToClipboard(context),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomButton(
                      onPressed: () => _shareReferral(context),
                      label: 'Share Referral Link',
                      backgroundColor: AppColors.successGreen,
                      isFullWidth: true,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Referred Users Section
            Text(
              'Your Referrals',
              style: AppTextStyles.headlineMedium(context),
            ),
            const SizedBox(height: 16),
            referredUsers.isEmpty
                ? _buildEmptyState(context)
                : ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: referredUsers.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final user = referredUsers[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryBlue.withOpacity(0.2),
                    child: Icon(
                      Icons.person,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  title: Text(
                    user["name"]!,
                    style: AppTextStyles.titleMedium(context),
                  ),
                  subtitle: Text(
                    'Joined on ${user["joinedOn"]!}',
                    style: AppTextStyles.bodySmall(context),
                  ),
                  trailing: const Icon(Icons.verified, color: AppColors.successGreen),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No Referrals Yet',
            style: AppTextStyles.titleMedium(context)?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'People you refer will appear here',
            style: AppTextStyles.bodyMedium(context)?.copyWith(
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> _copyToClipboard(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: referralCode));
    Fluttertoast.showToast(
      msg: 'Referral code copied!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.primaryBlue,
      textColor: Colors.white,
    );
  }

  Future<void> _shareReferral(BuildContext context) async {
    // In a real app, you would implement actual sharing functionality
    const referralLink = 'https://brokershub.com/signup?ref=NEXS123ALI';
    await Clipboard.setData(const ClipboardData(text: referralLink));
    Fluttertoast.showToast(
      msg: 'Referral link copied!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.successGreen,
      textColor: Colors.white,
    );
  }
}