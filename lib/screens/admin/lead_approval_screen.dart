import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brokers_hub/core/constants/app_colors.dart';
import 'package:brokers_hub/core/constants/app_text_styles.dart';
import 'package:brokers_hub/widgets/common/custom_button.dart';
import 'package:brokers_hub/widgets/common/custom_card.dart';
import 'package:brokers_hub/providers/lead_provider.dart';
import 'package:brokers_hub/models/lead_model.dart';

class LeadApprovalScreen extends StatelessWidget {
  const LeadApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lead Approval Queue',
          style: AppTextStyles.headlineSmall(context),
        ),
      ),
      body: Consumer<LeadProvider>(
        builder: (context, leadProvider, child) {
          final pendingLeads = leadProvider.getLeadsByStatus('pending');

          if (pendingLeads.isEmpty) {
            return Center(
              child: Text(
                'No pending leads to approve',
                style: AppTextStyles.bodyLarge(context),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: pendingLeads.length,
            itemBuilder: (context, index) {
              final lead = pendingLeads[index];
              return Dismissible(
                key: Key(lead.id),
                background: _buildSwipeBackground(AppColors.successGreen, 'APPROVE'),
                secondaryBackground: _buildSwipeBackground(AppColors.errorRed, 'REJECT'),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    _approveLead(context, leadProvider, lead.id);
                    return false; // Don't dismiss, let the provider handle it
                  } else {
                    _rejectLead(context, leadProvider, lead.id);
                    return false; // Don't dismiss, let the provider handle it
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: CustomCard(
                    title: lead.title,
                    subtitle: '${lead.serviceType} • ${lead.location}',
                    badgeText: lead.urgency,
                    onTap: () => _showLeadDetails(context, lead),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSwipeBackground(Color color, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: text == 'APPROVE'
          ? Alignment.centerLeft
          : Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  void _approveLead(BuildContext context, LeadProvider leadProvider, String leadId) {
    leadProvider.updateLeadStatus(leadId, 'matched');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Lead approved successfully'),
        backgroundColor: AppColors.successGreen,
      ),
    );
  }

  void _rejectLead(BuildContext context, LeadProvider leadProvider, String leadId) {
    // In a real app, you might want to archive instead of removing
    leadProvider.updateLeadStatus(leadId, 'rejected');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Lead rejected'),
        backgroundColor: AppColors.errorRed,
      ),
    );
  }

  void _showLeadDetails(BuildContext context, LeadModel lead) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(lead.title, style: AppTextStyles.headlineSmall(context)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Client: ${lead.clientName}', style: AppTextStyles.bodyMedium(context)),
            const SizedBox(height: 8),
            Text('Service: ${lead.serviceType}', style: AppTextStyles.bodyMedium(context)),
            const SizedBox(height: 8),
            Text('Location: ${lead.location}', style: AppTextStyles.bodyMedium(context)),
            const SizedBox(height: 8),
            Text('Budget: ${lead.budgetRange}', style: AppTextStyles.bodyMedium(context)),
            const SizedBox(height: 16),
            Text('Description:', style: AppTextStyles.labelLarge(context)),
            Text(lead.description, style: AppTextStyles.bodyMedium(context)),
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
}