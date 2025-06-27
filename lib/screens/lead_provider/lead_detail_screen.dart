import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_theme.dart';
import '../../models/lead_model.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_card.dart';

class LeadDetailScreen extends StatelessWidget {
  final LeadModel lead;
  final bool showChatButton;

  const LeadDetailScreen({
    super.key,
    required this.lead,
    this.showChatButton = true,
  });

  static Route route(LeadModel lead, {bool showChatButton = true}) {
    return MaterialPageRoute(
      builder: (context) => LeadDetailScreen(
        lead: lead,
        showChatButton: showChatButton,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lead Details', style: theme.textTheme.titleLarge),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Section
            CustomCard(
              title: lead.title,
              subtitle: 'Posted ${_formatDate(lead.createdAt)}',
              badgeText: lead.status,
              onTap: () {},
            ),
            const SizedBox(height: 16),

            // Client Info Section
            _buildSectionTitle('Client Information', theme),
            CustomCard(
              title: lead.clientName,
              subtitle: lead.contactInfo,
              badgeText: '',
              onTap: () {},
            ),
            const SizedBox(height: 16),

            // Lead Details Section
            _buildSectionTitle('Lead Details', theme),
            CustomCard(
              title: 'Details',
              subtitle: '''
              Service: ${lead.serviceType}
              Budget: ${lead.budgetRange}
              Location: ${lead.location}
              Urgency: ${lead.urgency}''',
              badgeText: '',
              onTap: () {},
            ),
            const SizedBox(height: 16),

            // Description Section
            _buildSectionTitle('Description', theme),
            CustomCard(
              title: 'Description',
              subtitle: lead.description,
              badgeText: '',
              onTap: () {},
            ),
            const SizedBox(height: 16),

            // Attachments Section
            if (lead.attachments?.isNotEmpty ?? false) ...[
              _buildSectionTitle('Attachments (${lead.attachments!.length})', theme),
              CustomCard(
                title: 'Attachments',
                subtitle: lead.attachments!.join('\n'),
                badgeText: '',
                onTap: () {},
              ),
              const SizedBox(height: 16),
            ],

            // Action Button
            if (showChatButton) ...[
              CustomButton(
                onPressed: () => Navigator.pushNamed(context, '/chat'),
                label: 'Chat with Provider',
              ),
              const SizedBox(height: 8),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM d, y').format(date);
  }
}