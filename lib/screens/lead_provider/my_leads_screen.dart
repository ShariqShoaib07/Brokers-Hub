import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brokers_hub/providers/lead_provider.dart';
import 'package:brokers_hub/widgets/common/custom_card.dart';
import 'package:brokers_hub/core/constants/app_colors.dart';

class MyLeadsScreen extends StatefulWidget {
  const MyLeadsScreen({super.key});

  @override
  State<MyLeadsScreen> createState() => _MyLeadsScreenState();
}

class _MyLeadsScreenState extends State<MyLeadsScreen> {
  String _currentFilter = 'All';

  final Map<String, String?> _filterOptions = {
    'All': null,
    'Pending': 'pending',
    'Matched': 'matched',
    'Finalized': 'finalized',
  };

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Leads'),
      ),
      body: Column(
        children: [
          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: _filterOptions.keys.map((String key) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(key),
                    selected: _currentFilter == key,
                    selectedColor: colorScheme.primary.withOpacity(0.2), // Replaced AppColors.primaryLight
                    onSelected: (bool selected) {
                      setState(() {
                        _currentFilter = key;
                      });
                    },
                    backgroundColor: colorScheme.surfaceVariant, // Replaced AppColors.grey20
                    labelStyle: TextStyle(
                      color: _currentFilter == key
                          ? colorScheme.primary // Replaced AppColors.primaryDark
                          : colorScheme.onSurface,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const Divider(height: 1),

          // Leads list
          Expanded(
            child: Consumer<LeadProvider>(
              builder: (context, leadProvider, child) {
                final leads = _currentFilter == 'All'
                    ? leadProvider.leads
                    : leadProvider.leads
                    .where((lead) => lead.status == _filterOptions[_currentFilter])
                    .toList();

                if (leads.isEmpty) {
                  return Center(
                    child: Text(
                      _currentFilter == 'All'
                          ? 'No leads posted yet'
                          : 'No $_currentFilter leads',
                      style: TextStyle(
                        color: colorScheme.onSurface.withOpacity(0.6), // Replaced AppColors.grey60
                      ),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    // You can add refresh logic here if needed
                  },
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: leads.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final lead = leads[index];
                      return CustomCard(
                        title: lead.title,
                        subtitle: lead.budgetRange,
                        badgeText: lead.status,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/lead-detail',
                            arguments: lead.id,
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}