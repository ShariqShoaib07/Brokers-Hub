import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brokers_hub/providers/lead_provider.dart';
import 'package:brokers_hub/widgets/common/custom_button.dart';
import 'package:brokers_hub/core/constants/app_colors.dart';
import 'package:brokers_hub/core/constants/app_text_styles.dart';
import 'package:brokers_hub/models/lead_model.dart';

class AvailableLeadsScreen extends StatefulWidget {
  const AvailableLeadsScreen({super.key});

  @override
  State<AvailableLeadsScreen> createState() => _AvailableLeadsScreenState();
}

class _AvailableLeadsScreenState extends State<AvailableLeadsScreen> {
  // Filter variables
  String? selectedCity;
  String? selectedServiceType;
  String? selectedBudgetRange;

  // Mock filter options
  final List<String> cities = ['All', 'Lahore', 'Karachi', 'Islamabad', 'Peshawar'];
  final List<String> serviceTypes = ['All', 'Solar', 'Construction', 'Plumbing', 'Electrical'];
  final List<String> budgetRanges = ['All', 'Under 50k', '50k-100k', '100k-200k', '200k+'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Available Leads',
          style: AppTextStyles.titleLarge(context),
        ),
      ),
      body: Column(
        children: [
          // Filters Section
          _buildFiltersSection(),
          const Divider(height: 1),
          // Leads List
          Expanded(
            child: Consumer<LeadProvider>(
              builder: (context, leadProvider, child) {
                // Filter leads based on selections
                List<LeadModel> filteredLeads = leadProvider.leads.where((lead) {
                  bool cityMatch = selectedCity == null ||
                      selectedCity == 'All' ||
                      lead.location == selectedCity;
                  bool serviceMatch = selectedServiceType == null ||
                      selectedServiceType == 'All' ||
                      lead.serviceType == selectedServiceType;

                  // Extract numeric value from budgetRange (e.g., "50,000 - 100,000 PKR" -> 50000)
                  String budgetStart = lead.budgetRange.split('-')[0].trim();
                  double budgetValue = double.parse(budgetStart.replaceAll(RegExp(r'[^0-9]'), ''));

                  bool budgetMatch = selectedBudgetRange == null ||
                      selectedBudgetRange == 'All' ||
                      _matchesBudgetRange(budgetValue, selectedBudgetRange!);

                  return cityMatch && serviceMatch && budgetMatch;
                }).toList();

                if (filteredLeads.isEmpty) {
                  return Center(
                    child: Text(
                      'No leads available',
                      style: AppTextStyles.bodyLarge(context),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredLeads.length,
                  itemBuilder: (context, index) {
                    final lead = filteredLeads[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lead.title,
                                style: AppTextStyles.headlineSmall(context),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: AppColors.darkTextSecondary,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    lead.location,
                                    style: AppTextStyles.bodySmall(context),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.attach_money,
                                    size: 16,
                                    color: AppColors.darkTextSecondary,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    lead.budgetRange,
                                    style: AppTextStyles.bodyMedium(context),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.accentNeonPurple.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Pending',
                                      style: AppTextStyles.labelSmall(context).copyWith(
                                        color: AppColors.accentNeonPurple,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              CustomButton(
                                onPressed: () => Navigator.pushNamed(
                                  context,
                                  '/lead-application',
                                  arguments: lead,
                                ),
                                label: 'Apply',
                                backgroundColor: AppColors.primaryBlue,
                                textColor: Colors.white,
                                isFullWidth: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filter Leads',
            style: AppTextStyles.titleMedium(context),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: selectedCity,
                  hint: Text('City', style: AppTextStyles.bodyMedium(context)),
                  items: cities.map((city) {
                    return DropdownMenuItem<String>(
                      value: city,
                      child: Text(city),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCity = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: selectedServiceType,
                  hint: Text('Service', style: AppTextStyles.bodyMedium(context)),
                  items: serviceTypes.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedServiceType = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: selectedBudgetRange,
            hint: Text('Budget Range', style: AppTextStyles.bodyMedium(context)),
            items: budgetRanges.map((range) {
              return DropdownMenuItem<String>(
                value: range,
                child: Text(range),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedBudgetRange = value;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
          const SizedBox(height: 12),
          CustomButton(
            onPressed: () {
              // Reset filters
              setState(() {
                selectedCity = null;
                selectedServiceType = null;
                selectedBudgetRange = null;
              });
            },
            label: 'Reset Filters',
            backgroundColor: AppColors.secondaryPurple,
            textColor: Colors.white,
            isFullWidth: true,
          ),
        ],
      ),
    );
  }

  bool _matchesBudgetRange(double budget, String range) {
    switch (range) {
      case 'Under 50k':
        return budget < 50000;
      case '50k-100k':
        return budget >= 50000 && budget <= 100000;
      case '100k-200k':
        return budget > 100000 && budget <= 200000;
      case '200k+':
        return budget > 200000;
      default:
        return true;
    }
  }
}