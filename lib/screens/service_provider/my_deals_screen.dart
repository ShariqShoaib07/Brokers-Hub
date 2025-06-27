import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // Added for DateFormat
import 'package:brokers_hub/providers/lead_provider.dart';
import 'package:brokers_hub/core/constants/app_colors.dart';
import 'package:brokers_hub/core/constants/app_text_styles.dart';

class MyDealsScreen extends StatelessWidget {
  const MyDealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final leadProvider = Provider.of<LeadProvider>(context);
    final myDeals = leadProvider.applications.where((app) =>
        ['applied', 'in_progress', 'finalized'].contains(app.status)
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Deals',
          style: AppTextStyles.headlineSmall(context),
        ),
      ),
      body: myDeals.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assignment_outlined,
              size: 48,
              color: AppColors.darkTextSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'No active deals yet',
              style: AppTextStyles.bodyLarge(context),
            ),
            const SizedBox(height: 8),
            Text(
              'Apply to leads to see them here',
              style: AppTextStyles.bodySmall(context),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: myDeals.length,
        itemBuilder: (context, index) {
          final deal = myDeals[index];
          final lead = leadProvider.getLeadById(deal.leadId);

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          lead?.title ?? 'Unknown Lead',
                          style: AppTextStyles.titleMedium(context), // Changed from subheading to titleMedium
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(deal.status),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _formatStatus(deal.status),
                          style: AppTextStyles.labelSmall(context)
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  DealProgressIndicator(status: deal.status),
                  const SizedBox(height: 8),
                  Text(
                    'Applied on ${DateFormat('MMM dd, yyyy').format(deal.appliedAt)}',
                    style: AppTextStyles.bodySmall(context),
                  ),
                  if (deal.status == 'finalized' && deal.rating != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColors.warningYellow,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Rating: ${deal.rating!.toStringAsFixed(1)}',
                            style: AppTextStyles.bodySmall(context),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'in_progress':
        return AppColors.primaryBlue;
      case 'finalized':
        return AppColors.successGreen;
      default: // applied
        return AppColors.secondaryPurple;
    }
  }

  String _formatStatus(String status) {
    return status.replaceAll('_', ' ').toUpperCase();
  }
}

class DealProgressIndicator extends StatelessWidget {
  final String status;

  const DealProgressIndicator({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final currentStep = status == 'applied'
        ? 0
        : status == 'in_progress'
        ? 1
        : 2;

    return Column(
      children: [
        Row(
          children: [
            _buildStep(context, 0, 'Applied', currentStep),
            _buildConnector(context, currentStep > 0),
            _buildStep(context, 1, 'In Progress', currentStep),
            _buildConnector(context, currentStep > 1),
            _buildStep(context, 2, 'Finalized', currentStep),
          ],
        ),
      ],
    );
  }

  Widget _buildStep(BuildContext context, int step, String label, int currentStep) {
    final isActive = currentStep >= step;
    final isCompleted = currentStep > step;

    return Column(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.secondaryPurple // Changed from accentColor to secondaryPurple
                : Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
          child: isCompleted
              ? Icon(
            Icons.check,
            size: 16,
            color: Colors.white,
          )
              : null,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.labelSmall(context).copyWith(
            color: isActive ? AppColors.secondaryPurple : Colors.grey, // Changed from accentColor to secondaryPurple
          ),
        ),
      ],
    );
  }

  Widget _buildConnector(BuildContext context, bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        color: isActive ? AppColors.secondaryPurple : Colors.grey.shade300, // Changed from accentColor to secondaryPurple
      ),
    );
  }
}