import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brokers_hub/providers/auth_provider.dart';
import 'package:brokers_hub/providers/lead_provider.dart';
import 'package:brokers_hub/widgets/layout/bottom_nav_bar.dart';
import 'package:brokers_hub/widgets/common/custom_card.dart';

class LeadDashboardScreen extends StatelessWidget {
  const LeadDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lead Provider Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome message
              Text(
                'Welcome, ${user?.name ?? 'Lead Provider'}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),

              // Stats cards
              _buildStatsRow(),
              const SizedBox(height: 24),

              // Post New Lead button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/post-lead'),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text('Post New Lead'),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Recent Leads section
              Text(
                'Recent Leads',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),
              Expanded(
                child: Consumer<LeadProvider>(
                  builder: (context, leadProvider, child) {
                    final recentLeads = leadProvider.leads.take(3).toList();

                    if (recentLeads.isEmpty) {
                      return const Center(
                        child: Text('No leads posted yet'),
                      );
                    }

                    return ListView.separated(
                      itemCount: recentLeads.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final lead = recentLeads[index];
                        return CustomCard(
                          title: lead.title,
                          subtitle: '${lead.budgetRange} • ${lead.location}',
                          badgeText: lead.status,
                          onTap: () {
                            // Navigate to lead detail screen
                            Navigator.pushNamed(
                              context,
                              '/lead-detail',
                              arguments: lead.id,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _StatCard(
          title: 'Total Leads',
          value: '24',
          icon: Icons.assignment,
          color: Colors.blue,
        ),
        _StatCard(
          title: 'Total Earnings',
          value: '₹85,000',
          icon: Icons.attach_money,
          color: Colors.green,
        ),
        _StatCard(
          title: 'Referrals',
          value: '5',
          icon: Icons.people,
          color: Colors.orange,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 8),
              Text(
                value,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}